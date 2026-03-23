require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local function recenter()
    vim.cmd "normal! zz"
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "n", "nzz", { desc = "Next search result (centered)" })
map("n", "N", "Nzz", { desc = "Previous search result (centered)" })
map("n", "*", "*zz", { desc = "Search word forward (centered)" })
map("n", "#", "#zz", { desc = "Search word backward (centered)" })
map("n", "g*", "g*zz", { desc = "Search partial word forward (centered)" })
map("n", "g#", "g#zz", { desc = "Search partial word backward (centered)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local function lsp_telescope(picker)
    return function()
        require("telescope.builtin")[picker]()
    end
end

-- LSP navigation via Telescope (single result -> new tab, multiple -> picker)
map("n", "gd", lsp_telescope "lsp_definitions", { desc = "Go to definition (Telescope)" })
map("n", "gi", lsp_telescope "lsp_implementations", { desc = "Go to implementation (Telescope)" })
map("n", "gr", lsp_telescope "lsp_references", { desc = "Find references (Telescope)" })
map("n", "gD", lsp_telescope "lsp_type_definitions", { desc = "Go to type definition (Telescope)" })

map("n", "]c", function()
    require("gitsigns").next_hunk()
    recenter()
end, { desc = "Next git hunk" })
map("n", "[c", function()
    require("gitsigns").prev_hunk()
    recenter()
end, { desc = "Previous git hunk" })

-- Lazygit floating term
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

map("n", "<leader>cc", "<cmd>Compile<cr>", { desc = "Compile (prompt)" })
map("n", "<leader>cC", "<cmd>Recompile<cr>", { desc = "Recompile last command" })
map("n", "<leader>cn", "<cmd>NextError<cr>", { desc = "Next compile error" })
map("n", "<leader>cp", "<cmd>PrevError<cr>", { desc = "Previous compile error" })

-- LSP utilities
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "[d", function()
    vim.diagnostic.goto_prev()
    recenter()
end, { desc = "Previous diagnostic (centered)" })
map("n", "]d", function()
    vim.diagnostic.goto_next()
    recenter()
end, { desc = "Next diagnostic (centered)" })
