return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "c", "css", "html", "javascript", "json", "lua", "python", "vim", "vimdoc", "query", "typescript" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
