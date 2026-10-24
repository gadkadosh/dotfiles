return {
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    "tpope/vim-sleuth",
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- My Plugins
    {
        dir = "~/Code/pixem.nvim",
        cmd = "Pixem",
        opts = {},
    },
    {
        dir = "~/Code/vimsum.nvim",
        cmd = { "SumTimes", "SumColumn" },
        keys = {
            { "<leader>st", ":SumTimes<CR>", mode = "v" },
            { "<leader>sc", ":SumColumn<CR>", mode = "v" },
        },
        opts = {},
    },
}
