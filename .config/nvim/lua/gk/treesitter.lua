require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "glsl",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = true },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
