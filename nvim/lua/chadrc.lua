---@type ChadrcConfig
local M = {}

M.nvdash = { load_on_startup = true }

M.base46 = {
    theme = "gruvbox_light",
    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
}

M.ui = {
    tabufline = {
        lazyload = false,
    },
}

return M
