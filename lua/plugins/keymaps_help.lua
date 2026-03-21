-- 快捷键速查弹窗，按 <leader>hk 打开
-- 添加快捷键：在下方 sections 对应分类的 items 里加 { "快捷键", "说明" }
-- 新增分类：添加 { title = "分类名", items = { ... } }

local sections = {
  {
    title = " 通用",
    items = {
      { "<leader>",   "空格键（前缀键）" },
      { "<leader>hk", "打开本速查表" },
      { ":w",         "保存文件" },
      { ":q",         "退出" },
      { "u",          "撤销" },
      { "Ctrl-r",     "重做" },
      { ".",          "重复上一次操作" },
    },
  },
  {
    title = " 文件与搜索",
    items = {
      { "<leader>ff", "查找文件" },
      { "<leader>fg", "全局搜索文本" },
      { "<leader>fr", "最近打开的文件" },
      { "<leader>fb", "切换 Buffer" },
      { "<leader>e",  "文件浏览器" },
    },
  },
  {
    title = " 窗口与 Buffer",
    items = {
      { "<leader>bd", "关闭当前 Buffer" },
      { "C-h/j/k/l",  "窗口间移动" },
      { "<leader>-",  "水平分割窗口" },
      { "<leader>|",  "垂直分割窗口" },
    },
  },
  {
    title = " 代码编辑",
    items = {
      { "gd",         "跳转到定义" },
      { "gr",         "查找引用" },
      { "K",          "显示悬浮文档" },
      { "<leader>ca", "代码操作" },
      { "<leader>cr", "重命名符号" },
      { "<leader>cf", "格式化代码" },
      { "gcc",        "注释/取消注释行" },
      { "gc",         "注释选中区域" },
    },
  },
  {
    title = " 诊断",
    items = {
      { "<leader>xx", "打开问题列表" },
      { "]d / [d",    "下/上一个诊断" },
      { "<leader>cd", "行内诊断浮窗" },
    },
  },
  {
    title = " Git",
    items = {
      { "<leader>gg", "打开 Lazygit" },
      { "<leader>gf", "文件 Git 日志" },
      { "]h / [h",    "下/上一个 hunk" },
    },
  },
  {
    title = " 终端",
    items = {
      { "<leader>ft", "打开浮动终端" },
      { "<C-/>",      "切换终端" },
    },
  },
}

-- 默认列数，可通过 :lua KEYMAPS_HELP_COLS=2 动态调整
local DEFAULT_COLS = 3

local function show_help(cols)
  cols = cols or DEFAULT_COLS

  -- 每个 section 渲染为独立的行块
  local sec_blocks = {}
  for _, sec in ipairs(sections) do
    local block = {}
    table.insert(block, "── " .. sec.title .. " ──")
    table.insert(block, "")
    for _, item in ipairs(sec.items) do
      table.insert(block, string.format("  %-14s %s", item[1], item[2]))
    end
    table.insert(sec_blocks, block)
  end

  -- 按列数分组 sections
  local col_groups = {}
  for i = 1, #sec_blocks, cols do
    local group = {}
    for j = i, math.min(i + cols - 1, #sec_blocks) do
      table.insert(group, sec_blocks[j])
    end
    table.insert(col_groups, group)
  end

  -- 计算每列宽度
  local win_width = math.floor(vim.o.columns * 0.9)
  local col_width = math.floor((win_width - 2) / cols)
  local sep = "│"

  -- 逐行组装
  local lines = { "", "    ⌨️  快捷键速查", "" }

  for _, group in ipairs(col_groups) do
    -- 找出这组中最大行数
    local max_rows = 0
    for _, block in ipairs(group) do
      if #block > max_rows then max_rows = #block end
    end

    for row = 1, max_rows do
      local parts = {}
      for c, block in ipairs(group) do
        local text = block[row] or ""
        -- 计算显示宽度（中文字符占2宽）
        local display_w = vim.fn.strdisplaywidth(text)
        local pad = col_width - display_w - 1
        if pad < 0 then pad = 0 end
        local cell = " " .. text .. string.rep(" ", pad)
        table.insert(parts, cell)
      end
      table.insert(lines, table.concat(parts, sep))
    end
    table.insert(lines, "")
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].swapfile = false

  -- 高亮
  local ns = vim.api.nvim_create_namespace("keymaps_help")
  for i, line in ipairs(lines) do
    if line:match("⌨") then
      vim.api.nvim_buf_add_highlight(buf, ns, "Title", i - 1, 0, -1)
    else
      -- 高亮分类标题
      local pos = 1
      while true do
        local s, e = line:find("── .-%s──", pos)
        if not s then break end
        vim.api.nvim_buf_add_highlight(buf, ns, "Function", i - 1, s - 1, e)
        pos = e + 1
      end
      -- 高亮快捷键（每个 cell 中缩进后的键名部分）
      for s, key_text in line:gmatch("()  (%-?%S+)%s%s") do
        if not key_text:match("──") then
          vim.api.nvim_buf_add_highlight(buf, ns, "Keyword", i - 1, s, s + #key_text + 1)
        end
      end
    end
  end

  local win_height = math.floor(vim.o.lines * 0.9)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = math.floor((vim.o.columns - win_width) / 2),
    row = math.floor((vim.o.lines - win_height) / 2),
    style = "minimal",
    border = "rounded",
  })
  vim.wo[win].cursorline = true
  vim.wo[win].winblend = 0

  local close = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true })
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>hk", function() show_help(DEFAULT_COLS) end, desc = "快捷键速查表" },
    },
  },
}
