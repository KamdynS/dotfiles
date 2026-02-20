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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "rust_analyzer" or vim.bo[args.buf].filetype ~= "rust" then
      return
    end

    if client.supports_method and client:supports_method("textDocument/inlayHint") and vim.lsp.inlay_hint then
      local ok = pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
      if not ok then
        pcall(vim.lsp.inlay_hint.enable, args.buf, true)
      end
    end
  end,
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
