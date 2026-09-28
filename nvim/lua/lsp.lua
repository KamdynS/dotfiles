-- Virtual diagnostic lines do not honor the normal 'wrap' option. Wrap their
-- messages explicitly against the narrowest window displaying the buffer.
local function buffer_window_width(bufnr)
    local width
    for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
        if vim.api.nvim_win_is_valid(win) then
            local info = vim.fn.getwininfo(win)[1] or {}
            local text_width = vim.api.nvim_win_get_width(win) - (info.textoff or 0)
            width = math.min(width or text_width, text_width)
        end
    end
    return math.max(width or vim.o.columns, 1)
end

local function take_display_width(text, max_width)
    local chars = vim.fn.strchars(text)
    local count = 0
    local low, high = 1, chars
    while low <= high do
        local middle = math.floor((low + high) / 2)
        if vim.fn.strdisplaywidth(vim.fn.strcharpart(text, 0, middle)) <= max_width then
            count = middle
            low = middle + 1
        else
            high = middle - 1
        end
    end
    count = math.max(count, 1)
    return vim.fn.strcharpart(text, 0, count), vim.fn.strcharpart(text, count)
end

local function wrap_line(line, width, output)
    local current = ""
    for word in line:gmatch "%S+" do
        local candidate = current == "" and word or current .. " " .. word
        if vim.fn.strdisplaywidth(candidate) <= width then
            current = candidate
        else
            if current ~= "" then
                output[#output + 1] = current
                current = ""
            end
            while vim.fn.strdisplaywidth(word) > width do
                local chunk
                chunk, word = take_display_width(word, width)
                output[#output + 1] = chunk
            end
            current = word
        end
    end
    output[#output + 1] = current
end

local function wrap_diagnostic(diagnostic, bufnr, window_width)
    local message = diagnostic.code and string.format("%s: %s", diagnostic.code, diagnostic.message)
        or diagnostic.message
    -- virtcol() matches Neovim's renderer and includes tabs plus inline hints.
    local indent_width = vim.api.nvim_buf_call(bufnr, function()
        return math.max(vim.fn.virtcol { diagnostic.lnum + 1, (diagnostic.col or 0) + 1 } - 1, 0)
    end)
    -- Native virtual lines add a six-cell connector before the message.
    local width = math.max(window_width - indent_width - 7, 1)
    local output = {}

    for line in (message .. "\n"):gmatch "(.-)\n" do
        wrap_line(line, width, output)
    end
    return table.concat(output, "\n")
end

vim.diagnostic.config {
    virtual_lines = function(_, bufnr)
        local window_width = buffer_window_width(bufnr)
        return {
            current_line = true,
            format = function(diagnostic)
                return wrap_diagnostic(diagnostic, bufnr, window_width)
            end,
        }
    end,
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = function(_, bufnr)
        return {
            border = "rounded",
            max_width = math.max(buffer_window_width(bufnr) - 4, 1),
        }
    end,
}

vim.api.nvim_create_autocmd("WinResized", {
    callback = function()
        local seen = {}
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if not seen[buf] then
                seen[buf] = true
                vim.diagnostic.show(nil, buf)
            end
        end
    end,
})

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
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
})

local ts_inlay = {
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayEnumMemberValueHints = true,
}

vim.lsp.config("ts_ls", {
    settings = {
        typescript = { inlayHints = ts_inlay },
        javascript = { inlayHints = ts_inlay },
    },
})

vim.lsp.enable {
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "pyright",
    "ts_ls",
    "html",
    "cssls",
    "clangd",
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client:supports_method "textDocument/inlayHint" then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", function()
            require("telescope.builtin").lsp_definitions()
        end, "Go to definition")
        map("n", "gr", function()
            require("telescope.builtin").lsp_references()
        end, "Find references")
        map("n", "gi", function()
            require("telescope.builtin").lsp_implementations()
        end, "Go to implementation")
        map("n", "gD", function()
            require("telescope.builtin").lsp_type_definitions()
        end, "Type definition")
        map("n", "K", vim.lsp.buf.hover, "Hover docs")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>f", function()
            vim.lsp.buf.format { async = true }
        end, "Format buffer")
        map("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle inlay hints")
    end,
})
