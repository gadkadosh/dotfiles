return {
    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        opts = {},
    },

    "tpope/vim-surround",
    "tpope/vim-eunuch",
    "tpope/vim-sleuth",
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Navigation
                vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Go to previous hunk" })
                vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Go to next hunk" })

                -- Actions
                vim.keymap.set({ "n", "v" }, "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "[H]unk [S]tage" })
                vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk,
                    { buffer = bufnr, desc = "[H]unk [U]ndo stage" })
                vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "[H]unk [P]review" })
                vim.keymap.set("n", "<leader>hb", function()
                    gs.blame_line { full = true }
                end, { buffer = bufnr, desc = "Blame line" })
                vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
            end,
        },
    },

    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        opts = {},
    },

    -- My Plugins
    {
        dir = "~/Code/vim-pixem",
        cmd = "Pixem",
        config = function()
            vim.g.pixem_use_rem = 1
        end
    }
}
