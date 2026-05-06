-- Keymaps
local map = vim.keymap.set

-- Better command mode
map("n", ";", ":", { desc = "Command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Centered navigation
map("n", "n", "nzz", { desc = "Next search (centered)" })
map("n", "N", "Nzz", { desc = "Prev search (centered)" })
map("n", "*", "*zz", { desc = "Search word forward" })
map("n", "#", "#zz", { desc = "Search word backward" })
map("n", "<C-d>", "<C-d>zz", { desc = "Page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Page up (centered)" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search" })

-- LSP keymaps (set in lsp.lua on attach)

-- Diagnostic navigation
map("n", "[d", function() vim.diagnostic.goto_prev() vim.cmd("normal! zz") end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.goto_next() vim.cmd("normal! zz") end, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic float" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
