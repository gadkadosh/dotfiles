return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.surround').setup()
            require('mini.statusline').setup()
        end
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
    },

    -- "tpope/vim-surround",
    "tpope/vim-eunuch",
    "tpope/vim-sleuth",
    {
        "tpope/vim-fugitive",
        enabled = false,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Navigation
                vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr })
                vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr })

                -- Actions
                vim.keymap.set({ "n", "v" }, "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "[H]unk [S]tage" })
                vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk,
                    { buffer = bufnr, desc = "[H]unk [U]ndo stage" })
                vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
                vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = bufnr })
                vim.keymap.set("n", "<leader>gB", gs.blame, { buffer = bufnr })
            end,
        },
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        opts = {},
    },

    -- My Plugins
    {
        dir = "~/Code/pixem.nvim",
        cmd = "Pixem",
        opts = {},
    },
    {
        dir = "~/Code/vimsum.nvim",
        config = function()
            require("vimsum").setup()
            vim.keymap.set("v", "<leader>st", ":SumTimes<cr>")
            vim.keymap.set("v", "<leader>sc", ":SumColumn<cr>")
        end
    }
}
