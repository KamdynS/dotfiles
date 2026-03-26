require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "gopls", "rust_analyzer", "pyright", "clangd", "ts_ls" }
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
    },
  },
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
