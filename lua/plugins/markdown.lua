return {
  {
    "3rd/image.nvim",
    rocks = { "magick" },
    event = "VeryLazy",
    opts = {
      backend = "kitty",
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign", "noice" },
    },
    config = function(_, opts)
      local image = require("image")
      image.setup(opts)

      local function render_leetcode_images(buf)
        local win = vim.fn.bufwinid(buf)
        if win == -1 then return end
        -- 只清理当前 buffer 关联的图片，避免全量删除导致无法恢复
        for _, img in ipairs(image.get_images({ buffer = buf })) do
          img:clear()
        end
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        for i, line in ipairs(lines) do
          local url = line:match("%[img%]%((.-)%)")
          if url then
            image.from_url(url, {
              buffer = buf,
              window = win,
              with_virtual_padding = true,
            }, function(img)
              if img then
                img.geometry.y = i - 1
                img.geometry.x = 0
                img:render()
                vim.schedule(function()
                  if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_call(win, function() vim.cmd("redraw!") end)
                  end
                end)
              end
            end)
          end
        end
      end

      -- 防抖调度
      local render_timer = nil
      local function schedule_render(buf, delay)
        if render_timer then
          render_timer:stop()
          render_timer:close()
          render_timer = nil
        end
        render_timer = vim.uv.new_timer()
        render_timer:start(delay, 0, vim.schedule_wrap(function()
          render_timer = nil
          if vim.api.nvim_buf_is_valid(buf) and vim.fn.bufwinid(buf) ~= -1 then
            render_leetcode_images(buf)
          end
        end))
      end

      -- filetype 设置时即触发
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "leetcode.nvim",
        callback = function(ev)
          schedule_render(ev.buf, 200)
        end,
      })

      -- 窗口大小变化后重新渲染图片
      vim.api.nvim_create_autocmd("WinResized", {
        callback = function()
          for _, win in ipairs(vim.v.event.windows or {}) do
            if vim.api.nvim_win_is_valid(win) then
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "leetcode.nvim" then
                -- 先隐藏旧图片避免重叠，再按新尺寸重新渲染
                local imgs = image.get_images({ buffer = buf })
                for _, img in ipairs(imgs) do
                  img:clear(true)
                end
                vim.schedule(function()
                  for _, img in ipairs(imgs) do
                    img:render()
                  end
                end)
                return
              end
            end
          end
        end,
      })
    end,
  },
}
