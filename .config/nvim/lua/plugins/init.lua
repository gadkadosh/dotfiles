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
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        cmd = "RenderMarkdown",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = ":call mkdp#util#install_sync()",
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
