return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = require "configs.conform",
    },
    {
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    },
    {
        "hedyhli/outline.nvim",
        cmd = "Outline",
        keys = {
            { "<leader>o", "<cmd>Outline<cr>", desc = "Toggle outline" },
        },
        opts = {
            outline_window = {
                position = "right",
                width = 25,
            },
            symbols = {
                icons = {
                    File = { icon = "󰈙", hl = "Identifier" },
                    Module = { icon = "󰆧", hl = "Include" },
                    Namespace = { icon = "󰅪", hl = "Include" },
                    Package = { icon = "󰏗", hl = "Include" },
                    Class = { icon = "", hl = "Type" },
                    Method = { icon = "󰊕", hl = "Function" },
                    Property = { icon = "", hl = "Identifier" },
                    Field = { icon = "", hl = "Identifier" },
                    Constructor = { icon = "", hl = "Special" },
                    Enum = { icon = "", hl = "Type" },
                    Interface = { icon = "", hl = "Type" },
                    Function = { icon = "󰊕", hl = "Function" },
                    Variable = { icon = "", hl = "Constant" },
                    Constant = { icon = "", hl = "Constant" },
                    String = { icon = "", hl = "String" },
                    Number = { icon = "󰎠", hl = "Number" },
                    Boolean = { icon = "", hl = "Boolean" },
                    Array = { icon = "󰅪", hl = "Constant" },
                    Object = { icon = "", hl = "Type" },
                    Key = { icon = "󰌋", hl = "Type" },
                    Null = { icon = "󰟢", hl = "Type" },
                    Struct = { icon = "", hl = "Type" },
                },
            },
        },
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "saecki/crates.nvim",
        ft = { "toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        opts = {
            delay = 300,
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            hijack_directories = {
                enable = true,
                auto_open = true,
            },
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "go",
                "lua",
                "python",
                "rust",
                "haskell",
                "javascript",
                "typescript",
                "c",
                "cpp",
                "vim",
                "vimdoc",
                "html",
                "css",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                winblend = 0, -- 0 = fully opaque, 100 = fully transparent
                border = true,
                file_ignore_patterns = { "node_modules/.*", ".git/.*" },
            },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = false,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
}
