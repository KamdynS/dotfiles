-- Minimal Neovim 0.12 config
-- Uses native LSP, native completion, lazy.nvim for plugins

-- Leader key (before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load config modules
require("options")
require("keymaps")
require("lsp")
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})

-- Load theme from rice's theming system
local theme_file = vim.fn.expand("~/.config/nvim-theme/active.lua")
if vim.uv.fs_stat(theme_file) then
  local theme = dofile(theme_file)
  if theme and theme.name then
    -- Map rice theme names to nvim colorschemes
    local colorscheme_map = {
      ["gruvbox-light"] = "retrobox",
      ["gruvbox-dark"] = "retrobox",
      ["catppuccin-mocha"] = "habamax",
      ["kanagawa"] = "habamax",
      ["rose-pine"] = "habamax",
      ["tokyonight"] = "habamax",
    }
    local bg = theme.polarity == "light" and "light" or "dark"
    vim.opt.background = bg
    pcall(vim.cmd.colorscheme, colorscheme_map[theme.name] or "default")
  end
end
