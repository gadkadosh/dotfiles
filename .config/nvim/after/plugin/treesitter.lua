if not pcall(require, "nvim-treesitter") then
    return
end

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "glsl",
        "graphql",
        "hcl",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "query",
        "rust",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
    },
    highlight = { enable = true },
    playground = { enable = true },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    autotag = {
        enable = true,
    },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
