# Neovim 配置

个人自用的 Neovim 配置，基于 [LazyVim](https://github.com/LazyVim/LazyVim)。

## 外部依赖

使用前需安装以下程序：

| 程序 | 安装方式 | 用途 |
|------|---------|------|
| [Neovim](https://neovim.io/) ≥ 0.10 | `brew install neovim` | 编辑器本体 |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | `brew install --cask kitty` | 终端，支持图片渲染协议 |
| [Git](https://git-scm.com/) | `brew install git` | 插件管理、LazyGit 等 |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `brew install ripgrep` | 全局文本搜索 (`<leader>fg`) |
| [fd](https://github.com/sharkdp/fd) | `brew install fd` | 文件查找 (`<leader>ff`) |
| [lazygit](https://github.com/jesseduffield/lazygit) | `brew install lazygit` | Git TUI (`<leader>gg`) |
| [ImageMagick](https://imagemagick.org/) | `brew install imagemagick` | LeetCode 题目图片渲染 |
| [luarocks](https://luarocks.org/) | `brew install luarocks` | 安装 lua 依赖（magick） |
| [curl](https://curl.se/) | 系统自带 | 下载远程图片 |

### Lua 依赖

```bash
luarocks --lua-version=5.1 install magick
```

## 插件概览

| 插件 | 说明 |
|------|------|
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | 主题配色（Mocha + 透明背景） |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | 文件浏览器侧边栏 |
| [leetcode.nvim](https://github.com/kawre/leetcode.nvim) | 在 Neovim 中刷 LeetCode |
| [image.nvim](https://github.com/3rd/image.nvim) | Kitty 图片协议渲染，用于显示 LeetCode 题目图片 |

### LazyVim Extras

- `lang.go` — Go 语言支持
- `lang.json` — JSON 语言支持
- `lang.markdown` — Markdown 语言支持

## 使用

```bash
# 克隆配置
git clone <repo-url> ~/.config/nvim

# 首次启动会自动安装所有插件
nvim

# 以 LeetCode 模式启动
nvim leetcode.nvim
```

## 快捷键

内置快捷键速查表，按 `<leader>hk` 打开。
