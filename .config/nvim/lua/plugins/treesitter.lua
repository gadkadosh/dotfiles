return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "c",
                "css",
                "graphql",
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
                callback = function()
                    if not pcall(vim.treesitter.start) then
                        return
                    end

                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo.foldmethod = "expr"
                    vim.wo.foldlevel = 99
                end,
            })
        end,
    },
}
