return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "c",
                "comment",
                "css",
                "html",
                "http",
                "javascript",
                "json",
                "lua",
                "python",
                "vim",
                "vimdoc",
                "query",
                "typescript",
                "tsx",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "<filetype>" },
                callback = function()
                    vim.treesitter.start()
                end,
            })

            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"

            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    },
}
