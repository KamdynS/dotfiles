-- Birren Industrial - A Neovim colorscheme inspired by 1940s industrial color theory
-- Based on Faber Birren's work with DuPont and the Manhattan Project
-- IMPROVED VERSION: Better contrast for actual code editing

local M = {}

-- Color palette - ADJUSTED for readability
local colors = {
    -- Background colors - slightly darker for better contrast
    bg0 = "#B8CAB8", -- Main background (darker than original #C5D5C5)
    bg1 = "#A8BDA8", -- Slightly darker
    bg2 = "#98AF98", -- Medium-light green
    bg3 = "#8FAA8F", -- Medium Green (dado/panels)

    -- Alternative backgrounds
    bg_beige = "#C4B4A0", -- Beige (darker)
    bg_cream = "#D8CCB8", -- Control panel cream

    -- Foreground/Text - MUCH DARKER for readability
    fg0 = "#1A2222", -- Near black (for maximum contrast)
    fg1 = "#2B3333", -- Very dark gray (strong emphasis)
    fg2 = "#3D4D4D", -- Dark gray (primary text) - MUCH darker than before
    fg3 = "#5B6B6B", -- Medium gray (comments)

    -- Safety color coding - DARKENED for better visibility on light background
    red = "#A83838", -- Fire Red (darker)
    orange = "#B66D2E", -- Alert Orange (darker)
    yellow = "#B48024", -- Solar Yellow (darker)
    green = "#4E8E4E", -- Safety Green (darker)
    blue = "#4B7A98", -- Caution Blue (darker)

    -- Additional colors - adjusted
    cyan = "#4E8E8E", -- Teal (darker)
    magenta = "#8E5B7A", -- Muted purple (darker)

    -- Extremes
    black = "#1A1F1F", -- Dial black
    white = "#F2EFE5", -- Gauge white

    -- UI specific - adjusted
    visual_bg = "#98AF98",
    search_bg = "#E4C044", -- Brighter yellow for visibility
    search_fg = "#1A2222",
    cursorline = "#A8BDA8",
    statusline_bg = "#8FAA8F",
    pmenu_bg = "#A8BDA8",
    pmenu_sel = "#8FAA8F",
}

function M.setup()
    vim.cmd "hi clear"
    if vim.fn.exists "syntax_on" then
        vim.cmd "syntax reset"
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "birren-industrial"

    -- Editor highlights
    local highlights = {
        -- Base - IMPROVED CONTRAST
        Normal = { fg = colors.fg2, bg = colors.bg0 },
        NormalFloat = { fg = colors.fg2, bg = colors.bg1 },
        Comment = { fg = colors.fg3, italic = true },

        -- Constants
        Constant = { fg = colors.fg0, bold = true },
        String = { fg = colors.green, bold = true },
        Character = { fg = colors.green },
        Number = { fg = colors.blue, bold = true },
        Boolean = { fg = colors.orange, bold = true },
        Float = { fg = colors.blue, bold = true },

        -- Identifiers
        Identifier = { fg = colors.fg1 },
        Function = { fg = colors.blue, bold = true },

        -- Statements
        Statement = { fg = colors.orange, bold = true },
        Conditional = { fg = colors.orange, bold = true },
        Repeat = { fg = colors.orange, bold = true },
        Label = { fg = colors.yellow, bold = true },
        Operator = { fg = colors.fg1 },
        Keyword = { fg = colors.red, bold = true }, -- Changed to red for visibility
        Exception = { fg = colors.red, bold = true },

        -- PreProc
        PreProc = { fg = colors.cyan, bold = true },
        Include = { fg = colors.cyan, bold = true },
        Define = { fg = colors.cyan, bold = true },
        Macro = { fg = colors.cyan, bold = true },
        PreCondit = { fg = colors.cyan, bold = true },

        -- Types
        Type = { fg = colors.blue, bold = true },
        StorageClass = { fg = colors.orange, bold = true },
        Structure = { fg = colors.blue, bold = true },
        Typedef = { fg = colors.blue, bold = true },

        -- Special
        Special = { fg = colors.magenta, bold = true },
        SpecialChar = { fg = colors.red },
        Tag = { fg = colors.blue },
        Delimiter = { fg = colors.fg2 },
        SpecialComment = { fg = colors.fg3, italic = true },
        Debug = { fg = colors.red },

        -- UI Elements
        Cursor = { fg = colors.bg0, bg = colors.fg0 },
        CursorLine = { bg = colors.cursorline },
        CursorColumn = { bg = colors.cursorline },
        ColorColumn = { bg = colors.bg1 },
        LineNr = { fg = colors.fg3, bg = colors.bg0 },
        CursorLineNr = { fg = colors.fg0, bg = colors.cursorline, bold = true },

        -- Visual mode
        Visual = { bg = colors.visual_bg },
        VisualNOS = { bg = colors.visual_bg },

        -- Search - HIGH CONTRAST
        Search = { fg = colors.search_fg, bg = colors.search_bg, bold = true },
        IncSearch = { fg = colors.bg0, bg = colors.yellow, bold = true },

        -- Status line
        StatusLine = { fg = colors.fg0, bg = colors.statusline_bg, bold = true },
        StatusLineNC = { fg = colors.fg3, bg = colors.bg2 },

        -- Tab line
        TabLine = { fg = colors.fg3, bg = colors.bg2 },
        TabLineFill = { bg = colors.bg2 },
        TabLineSel = { fg = colors.fg0, bg = colors.bg3, bold = true },

        -- Popup menu
        Pmenu = { fg = colors.fg2, bg = colors.pmenu_bg },
        PmenuSel = { fg = colors.fg0, bg = colors.pmenu_sel, bold = true },
        PmenuSbar = { bg = colors.bg2 },
        PmenuThumb = { bg = colors.bg3 },

        -- Splits
        VertSplit = { fg = colors.bg3 },
        WinSeparator = { fg = colors.bg3 },

        -- Folds
        Folded = { fg = colors.fg3, bg = colors.bg2 },
        FoldColumn = { fg = colors.fg3, bg = colors.bg0 },

        -- Diffs
        DiffAdd = { fg = colors.green, bg = colors.bg1, bold = true },
        DiffChange = { fg = colors.yellow, bg = colors.bg1, bold = true },
        DiffDelete = { fg = colors.red, bg = colors.bg1, bold = true },
        DiffText = { fg = colors.orange, bg = colors.bg2, bold = true },

        -- Spelling
        SpellBad = { fg = colors.red, undercurl = true, sp = colors.red },
        SpellCap = { fg = colors.yellow, undercurl = true, sp = colors.yellow },
        SpellRare = { fg = colors.magenta, undercurl = true, sp = colors.magenta },
        SpellLocal = { fg = colors.blue, undercurl = true, sp = colors.blue },

        -- Errors and warnings
        Error = { fg = colors.red, bold = true },
        ErrorMsg = { fg = colors.red, bg = colors.bg1, bold = true },
        WarningMsg = { fg = colors.orange, bold = true },

        -- Messages
        ModeMsg = { fg = colors.green, bold = true },
        MoreMsg = { fg = colors.blue, bold = true },
        Question = { fg = colors.yellow, bold = true },

        -- Directory
        Directory = { fg = colors.blue, bold = true },

        -- Special keys
        SpecialKey = { fg = colors.fg3 },
        NonText = { fg = colors.fg3 },
        Whitespace = { fg = colors.bg3 },

        -- Signs
        SignColumn = { bg = colors.bg0 },

        -- TreeSitter highlights - IMPROVED
        ["@variable"] = { fg = colors.fg2 },
        ["@variable.builtin"] = { fg = colors.orange, bold = true },
        ["@variable.parameter"] = { fg = colors.fg1 },
        ["@variable.member"] = { fg = colors.fg1 },
        ["@constant"] = { fg = colors.fg0, bold = true },
        ["@constant.builtin"] = { fg = colors.blue, bold = true },
        ["@module"] = { fg = colors.cyan, bold = true },
        ["@string"] = { fg = colors.green, bold = true },
        ["@number"] = { fg = colors.blue, bold = true },
        ["@boolean"] = { fg = colors.orange, bold = true },
        ["@function"] = { fg = colors.blue, bold = true },
        ["@function.builtin"] = { fg = colors.cyan, bold = true },
        ["@function.method"] = { fg = colors.blue, bold = true },
        ["@keyword"] = { fg = colors.red, bold = true },
        ["@keyword.function"] = { fg = colors.orange, bold = true },
        ["@keyword.return"] = { fg = colors.red, bold = true },
        ["@operator"] = { fg = colors.fg1 },
        ["@type"] = { fg = colors.blue, bold = true },
        ["@type.builtin"] = { fg = colors.blue, bold = true },
        ["@constructor"] = { fg = colors.blue, bold = true },
        ["@property"] = { fg = colors.fg1 },
        ["@comment"] = { fg = colors.fg3, italic = true },
        ["@punctuation.bracket"] = { fg = colors.fg2 },
        ["@punctuation.delimiter"] = { fg = colors.fg2 },
        ["@tag"] = { fg = colors.blue, bold = true },
        ["@tag.attribute"] = { fg = colors.cyan },
        ["@tag.delimiter"] = { fg = colors.fg2 },

        -- LSP
        DiagnosticError = { fg = colors.red, bold = true },
        DiagnosticWarn = { fg = colors.orange, bold = true },
        DiagnosticInfo = { fg = colors.blue },
        DiagnosticHint = { fg = colors.cyan },
        DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
        DiagnosticUnderlineWarn = { undercurl = true, sp = colors.orange },
        DiagnosticUnderlineInfo = { undercurl = true, sp = colors.blue },
        DiagnosticUnderlineHint = { undercurl = true, sp = colors.cyan },

        -- Git signs
        GitSignsAdd = { fg = colors.green, bold = true },
        GitSignsChange = { fg = colors.yellow, bold = true },
        GitSignsDelete = { fg = colors.red, bold = true },

        -- Telescope
        TelescopeNormal = { fg = colors.fg2, bg = colors.bg1 },
        TelescopeBorder = { fg = colors.bg3, bg = colors.bg1 },
        TelescopePromptNormal = { fg = colors.fg2, bg = colors.bg2 },
        TelescopePromptBorder = { fg = colors.bg3, bg = colors.bg2 },
        TelescopePromptTitle = { fg = colors.bg0, bg = colors.blue, bold = true },
        TelescopePreviewTitle = { fg = colors.bg0, bg = colors.green, bold = true },
        TelescopeResultsTitle = { fg = colors.bg0, bg = colors.orange, bold = true },
        TelescopeSelection = { fg = colors.fg0, bg = colors.bg3, bold = true },
        TelescopeSelectionCaret = { fg = colors.orange, bg = colors.bg3, bold = true },
        TelescopeMatching = { fg = colors.yellow, bold = true },

        -- NvimTree
        NvimTreeNormal = { fg = colors.fg2, bg = colors.bg1 },
        NvimTreeFolderName = { fg = colors.blue, bold = true },
        NvimTreeFolderIcon = { fg = colors.blue },
        NvimTreeOpenedFolderName = { fg = colors.blue, bold = true },
        NvimTreeRootFolder = { fg = colors.orange, bold = true },
        NvimTreeSpecialFile = { fg = colors.magenta },
        NvimTreeGitDirty = { fg = colors.yellow },
        NvimTreeGitNew = { fg = colors.green },
        NvimTreeGitDeleted = { fg = colors.red },

        -- WhichKey
        WhichKey = { fg = colors.blue, bold = true },
        WhichKeyGroup = { fg = colors.orange, bold = true },
        WhichKeyDesc = { fg = colors.fg2 },
        WhichKeySeparator = { fg = colors.fg3 },
        WhichKeyFloat = { bg = colors.bg1 },

        -- NvChad specific
        St_NormalMode = { fg = colors.bg0, bg = colors.blue, bold = true },
        St_InsertMode = { fg = colors.bg0, bg = colors.green, bold = true },
        St_VisualMode = { fg = colors.bg0, bg = colors.orange, bold = true },
        St_ReplaceMode = { fg = colors.bg0, bg = colors.red, bold = true },
        St_CommandMode = { fg = colors.fg0, bg = colors.yellow, bold = true },
        St_ConfirmMode = { fg = colors.bg0, bg = colors.magenta, bold = true },
        St_TerminalMode = { fg = colors.bg0, bg = colors.cyan, bold = true },

        -- LSP Semantic Tokens
        ["@lsp.type.class"] = { fg = colors.blue, bold = true },
        ["@lsp.type.decorator"] = { fg = colors.cyan },
        ["@lsp.type.enum"] = { fg = colors.blue, bold = true },
        ["@lsp.type.enumMember"] = { fg = colors.cyan },
        ["@lsp.type.function"] = { fg = colors.blue, bold = true },
        ["@lsp.type.interface"] = { fg = colors.blue, bold = true },
        ["@lsp.type.macro"] = { fg = colors.cyan, bold = true },
        ["@lsp.type.method"] = { fg = colors.blue, bold = true },
        ["@lsp.type.namespace"] = { fg = colors.cyan, bold = true },
        ["@lsp.type.parameter"] = { fg = colors.fg1 },
        ["@lsp.type.property"] = { fg = colors.fg1 },
        ["@lsp.type.struct"] = { fg = colors.blue, bold = true },
        ["@lsp.type.type"] = { fg = colors.blue, bold = true },
        ["@lsp.type.typeParameter"] = { fg = colors.blue, bold = true },
        ["@lsp.type.variable"] = { fg = colors.fg2 },
    }

    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

M.colors = colors

return M
