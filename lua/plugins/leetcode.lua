local leet_arg = "leetcode.nvim"

return {
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv(0, -1),
    cmd = "Leet",
    build = ":TSInstall html",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      arg = leet_arg,
      lang = "go",
      cn = {
        enabled = true,
      },
      editor = {
        reset_previous_code = false,
      },
      console = {
        size = {
          width = "75%",
          height = "40%",
        },
      },
    },
    config = function(_, opts)
      require("leetcode").setup(opts)

      -- NUI Layout 容器窗口透明
      vim.api.nvim_create_autocmd("WinNew", {
        callback = function()
          vim.schedule(function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local ok, blend = pcall(vim.api.nvim_get_option_value, "winblend", { win = win })
              if ok and blend == 100 then
                vim.api.nvim_set_option_value(
                  "winhighlight",
                  "Normal:NormalFloat,EndOfBuffer:NormalFloat",
                  { win = win }
                )
              end
            end
          end)
        end,
      })
    end,
  },
}
