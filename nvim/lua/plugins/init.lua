-- Plugins (lazy.nvim)
return {
  -- Treesitter (syntax highlighting) - pinned to master branch (legacy API)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "rust", "go", "python",
        "javascript", "typescript", "tsx",
        "html", "css", "json", "yaml", "toml",
        "c", "cpp", "nix", "bash", "markdown",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search buffer" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
    },
  },

  -- Gitsigns (git integration)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map("n", "]c", function() gs.nav_hunk("next") vim.cmd("normal! zz") end, "Next hunk")
        map("n", "[c", function() gs.nav_hunk("prev") vim.cmd("normal! zz") end, "Prev hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", gs.blame_line, "Blame line")
      end,
    },
  },

  -- Conform (formatting)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format" },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        python = { "black" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        nix = { "nixfmt" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },

  -- Trouble (diagnostics list)
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
    },
    opts = {},
  },

  -- Which-key (keybind hints)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300,
      icons = { mappings = false },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>f", group = "find" },
        { "<leader>h", group = "git hunk" },
        { "<leader>c", group = "code" },
        { "<leader>x", group = "diagnostics" },
      })
    end,
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },

  -- File explorer (nvim-tree, NvChad-style sidebar)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File explorer" },
      { "<leader>fe", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file" },
    },
    opts = {
      hijack_directories = { enable = true, auto_open = true },
      update_focused_file = { enable = true },
      view = { width = 32, side = "left", signcolumn = "no" },
      renderer = {
        group_empty = true,
        indent_markers = { enable = true },
        icons = { show = { folder_arrow = false } },
      },
      filters = { dotfiles = false },
      git = { enable = true },
      diagnostics = { enable = true },
      actions = { open_file = { quit_on_open = false } },
    },
  },

  -- Statusline (mini.statusline - lightweight)
  {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    opts = { use_icons = true },
  },

  -- Colorschemes for the rice's 6 themes
  { "ellisonleao/gruvbox.nvim",   lazy = false, priority = 1000 },
  { "catppuccin/nvim",            lazy = false, priority = 1000, name = "catppuccin" },
  { "rebelot/kanagawa.nvim",      lazy = false, priority = 1000 },
  { "rose-pine/neovim",           lazy = false, priority = 1000, name = "rose-pine" },
  { "folke/tokyonight.nvim",      lazy = false, priority = 1000 },
}
