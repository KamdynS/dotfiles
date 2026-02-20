require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Helper: open Telescope LSP picker where <CR> opens in a new tab.
-- If there's only one result, jump_type = "tab" auto-opens it in a new tab.
local function lsp_telescope(picker)
    return function()
        local actions = require "telescope.actions"
        require("telescope.builtin")[picker] {
            jump_type = "tab",
            attach_mappings = function(_, map_keys)
                map_keys("i", "<CR>", actions.select_tab)
                map_keys("n", "<CR>", actions.select_tab)
                return true
            end,
        }
    end
end

-- LSP navigation via Telescope (single result -> new tab, multiple -> picker)
map("n", "gd", lsp_telescope("lsp_definitions"), { desc = "Go to definition (Telescope)" })
map("n", "gi", lsp_telescope("lsp_implementations"), { desc = "Go to implementation (Telescope)" })
map("n", "gr", lsp_telescope("lsp_references"), { desc = "Find references (Telescope)" })
map("n", "gD", lsp_telescope("lsp_type_definitions"), { desc = "Go to type definition (Telescope)" })

map("n", "]c", function()
    require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
map("n", "[c", function()
    require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })

-- Lazygit floating term
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Custom build and run script
map("n", "<leader>rr", function()
    require("configs.buildrun").build_and_run()
end, { desc = "Build and Run" })

-- LSP utilities
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
