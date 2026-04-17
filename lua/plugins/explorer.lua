return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true, -- 显示 gitignored 文件
          },
          explorer = {
            hidden = true,
            ignored = true, -- 目录树中显示 gitignored 文件
            layout = {
              preset = "sidebar",
              layout = {
                backdrop = false,
                width = 40,
                min_width = 40,
                height = 0,
                position = "left",
                border = "none",
                box = "vertical",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", height = 0.4, border = "top" },
              },
            },
          },
        },
      },
    },
  },
}
