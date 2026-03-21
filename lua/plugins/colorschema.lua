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
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        snacks = true,
        telescope = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.special.bufferline").get_theme()
          end
        end,
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
            "FloatBorder",
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
            "NotifyBackground",
            "WhichKeyFloat",
            "Pmenu",
          }
          for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, transparent)
          end
          -- 窗口分割线颜色
          vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#585b70", bg = "NONE" })
        end,
      })
    end,
  },
}
