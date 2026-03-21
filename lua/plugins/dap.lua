-- GoLand 风格调试快捷键
-- 全局：F9（开始/继续）、Cmd+F8（断点）、Cmd+Shift+F8（条件断点）
-- 仅调试会话中：F7/F8/Shift-F8/Alt-F8/Alt-F9

return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F9>",     function() require("dap").continue() end,                                              desc = "DAP: 继续/开始调试" },
      { "<D-F8>",   function() require("dap").toggle_breakpoint() end,                                     desc = "DAP: 打/取消断点" },
      { "<D-S-F8>", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,  desc = "DAP: 条件断点" },
    },
    config = function()
      local dap = require("dap")

      local session_keys = {
        { "n",          "<F8>",   function() dap.step_over() end,           "DAP: Step Over" },
        { "n",          "<F7>",   function() dap.step_into() end,           "DAP: Step Into" },
        { "n",          "<S-F8>", function() dap.step_out() end,            "DAP: Step Out" },
        { "n",          "<M-F9>", function() dap.run_to_cursor() end,       "DAP: Run to Cursor" },
        { { "n", "x" }, "<M-F8>", function() require("dapui").eval() end,   "DAP: Evaluate" },
      }

      dap.listeners.after.event_initialized["goland_keymaps"] = function()
        for _, k in ipairs(session_keys) do
          vim.keymap.set(k[1], k[2], k[3], { desc = k[4] })
        end
      end

      local function remove_keymaps()
        for _, k in ipairs(session_keys) do
          pcall(vim.keymap.del, k[1], k[2])
        end
      end

      dap.listeners.before.event_terminated["goland_keymaps"] = remove_keymaps
      dap.listeners.before.event_exited["goland_keymaps"] = remove_keymaps
    end,
  },

  -- Go 调试适配器
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    opts = {},
  },
}
