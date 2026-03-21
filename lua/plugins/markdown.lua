return {
  {
    "3rd/image.nvim",
    rocks = { "magick" },
    event = "VeryLazy",
    opts = {
      backend = "kitty",
    },
    config = function(_, opts)
      local image = require("image")
      image.setup(opts)

      local function render_leetcode_images(buf)
        local win = vim.fn.bufwinid(buf)
        if win == -1 then return end
        image.clear()
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

      -- filetype 设置时即触发，无需焦点在题目窗口
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "leetcode.nvim",
        callback = function(ev)
          vim.defer_fn(function() render_leetcode_images(ev.buf) end, 200)
        end,
      })

      -- 切回题目窗口时重新渲染
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = "*",
        callback = function(ev)
          if vim.bo[ev.buf].filetype == "leetcode.nvim" then
            render_leetcode_images(ev.buf)
          end
        end,
      })
    end,
  },
}
