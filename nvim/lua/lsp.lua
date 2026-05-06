-- Native LSP configuration (Neovim 0.12+)
-- LSPs are installed via Nix, not Mason

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded" },
})

-- LSP server configs
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
      inlayHints = {
        chainingHints = { enable = true },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
})

-- Enable LSP servers (installed via Nix)
vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
  "gopls",
  "pyright",
  "ts_ls",
  "html",
  "cssls",
  "clangd",
  "nil_ls", -- Nix
})

-- On attach: keymaps + inlay hints + native completion
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Enable inlay hints
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Enable native completion (0.12+)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, args.data.client_id, bufnr, { autotrigger = true })
    end

    -- LSP keymaps
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "gd", function() require("telescope.builtin").lsp_definitions() end, "Go to definition")
    map("n", "gr", function() require("telescope.builtin").lsp_references() end, "Find references")
    map("n", "gi", function() require("telescope.builtin").lsp_implementations() end, "Go to implementation")
    map("n", "gD", function() require("telescope.builtin").lsp_type_definitions() end, "Type definition")
    map("n", "K", vim.lsp.buf.hover, "Hover docs")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
  end,
})
