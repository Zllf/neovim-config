local sp = "#585b70"
-- 非选中元素：透明背景 + 底部下划线
local function underline(opts)
  return vim.tbl_extend("force", { bg = "NONE", underline = true, sp = sp }, opts or {})
end
-- 选中元素：透明背景，无下划线
local function selected(opts)
  return vim.tbl_extend("force", { bg = "NONE", bold = true, italic = false }, opts or {})
end

return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = {
        fill = underline(),
        background = underline(),
        buffer_visible = underline(),
        buffer_selected = selected(),

        close_button = underline(),
        close_button_visible = underline(),
        close_button_selected = selected(),

        modified = underline(),
        modified_visible = underline(),
        modified_selected = selected(),

        duplicate = underline(),
        duplicate_visible = underline(),
        duplicate_selected = selected(),

        tab = underline(),
        tab_close = underline(),
        tab_selected = selected(),
        tab_separator = underline({ fg = sp }),
        tab_separator_selected = { bg = "NONE", fg = sp },

        separator = underline({ fg = sp }),
        separator_visible = underline({ fg = sp }),
        separator_selected = { bg = "NONE", fg = sp },

        indicator_visible = underline(),
        indicator_selected = { bg = "NONE", fg = "#89b4fa" },

        pick = underline(),
        pick_visible = underline(),
        pick_selected = selected(),

        diagnostic = underline(),
        diagnostic_visible = underline(),
        diagnostic_selected = selected(),

        hint = underline(),
        hint_visible = underline(),
        hint_selected = selected(),
        hint_diagnostic = underline(),
        hint_diagnostic_visible = underline(),
        hint_diagnostic_selected = selected(),

        info = underline(),
        info_visible = underline(),
        info_selected = selected(),
        info_diagnostic = underline(),
        info_diagnostic_visible = underline(),
        info_diagnostic_selected = selected(),

        warning = underline(),
        warning_visible = underline(),
        warning_selected = selected(),
        warning_diagnostic = underline(),
        warning_diagnostic_visible = underline(),
        warning_diagnostic_selected = selected(),

        error = underline(),
        error_visible = underline(),
        error_selected = selected(),
        error_diagnostic = underline(),
        error_diagnostic_visible = underline(),
        error_diagnostic_selected = selected(),

        numbers = underline(),
        numbers_visible = underline(),
        numbers_selected = selected(),

        offset_separator = underline({ fg = sp }),
        trunc_marker = underline(),
      },
    },
  },
}
