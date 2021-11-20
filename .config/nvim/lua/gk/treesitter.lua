require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "cpp",
        "c",
        "cmake",
        "glsl",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "vue",
        "json",
        "lua",
        "python",
        "vim",
        "bash",
    },
    highlight = { enable = true },
    indent = { enable = true },
    -- context_commentstring = { enable = true },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
