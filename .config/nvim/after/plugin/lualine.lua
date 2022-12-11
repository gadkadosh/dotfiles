local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

lualine.setup {
    winbar = {
        lualine_b = { { "filename", path = 1 } },
    },
    inactive_winbar = {
        lualine_b = { { "filename", path = 1 } },
    },
}
