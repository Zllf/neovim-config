return {
  -- Noice 接管了 LSP hover/signature，在这里加边框
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
