return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { "c", "css", "html", "javascript", "json", "lua", "python", "vim", "vimdoc", "query", "typescript", "tsx" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
