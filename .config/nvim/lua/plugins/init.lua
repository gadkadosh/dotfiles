return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "c", "css", "html", "javascript", "json", "lua", "python", "vim", "vimdoc", "query", "typescript" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        opts = {},
    },

    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                css = { { "prettierd" } },
                html = { "prettierd" },
                htmldjango = { "prettierd" },
                javascript = { { "prettierd" } },
                javascriptreact = { { "prettierd" } },
                typescriptreact = { { "prettierd" } },
                python = { "black" },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
            vim.keymap.set({ "n", "v" }, "<leader>f", function() require("conform").format({ lsp_fallback = true }) end)
        end,
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
                transparent = true,
            })
            vim.cmd.colorscheme "tokyonight"
        end,
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
        config = function()
            vim.opt.termguicolors = true
            require("colorizer").setup()
        end,
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
