return {
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      integrations = {
        blink_cmp = true,
        flash = true,
        gitsigns = true,
        grug_far = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        noice = true,
        notify = true,
        snacks = true,
        treesitter_context = true,
        which_key = true,
      },
    },

  },
  -- 设置 LazyVim 使用 catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
    init = function()
      -- colorscheme 加载后强制所有 Snacks 窗口透明
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local transparent = { bg = "NONE" }
          local groups = {
            "NormalFloat",
            "FloatTitle",
            "SnacksNormal",
            "SnacksNormalNC",
            "SnacksPicker",
            "SnacksPickerInput",
            "SnacksPickerList",
            "SnacksPickerPreview",
            "SnacksPickerBorder",
            "LazyNormal",
            "MasonNormal",
            "NoicePopup",
            "NoicePopupmenu",
            "NormalSB",
            "NotifyBackground",
            "WhichKeyFloat",
            "EndOfBuffer",
          }
          for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, transparent)
          end
          -- 窗口分割线颜色
          vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#585b70", bg = "NONE" })
          -- 浮动窗口边框：统一灰色前景，透明背景（gK、hover 等均生效）
          vim.api.nvim_set_hl(0, "FloatBorder",  { fg = "#585b70", bg = "NONE" })
          -- 补全弹窗：背景透明，保留边框线颜色
          vim.api.nvim_set_hl(0, "Pmenu",       { bg = "NONE" })
          vim.api.nvim_set_hl(0, "PmenuBorder", { fg = "#585b70", bg = "NONE" })
        end,
      })
    end,
  },
}
