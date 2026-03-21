-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Apple Silicon: 让 magick 能找到 ImageMagick 动态库
vim.env.DYLD_LIBRARY_PATH = "/opt/homebrew/lib:" .. (vim.env.DYLD_LIBRARY_PATH or "")
