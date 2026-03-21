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
    },
  },
}
