local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    "lewis6991/impatient.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require "gk.treesitter"
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("Comment").setup {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },
    { "windwp/nvim-autopairs", config = true },
    { "windwp/nvim-ts-autotag", config = true },
    "tpope/vim-surround",
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            char = "┊",
            show_trailing_blankline_indent = false,
            show_first_indent_level = false,
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Telescope
    "kyazdani42/nvim-web-devicons",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    "nvim-telescope/telescope-file-browser.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            winbar = {
                lualine_b = { { "filename", path = 1 } },
            },
            inactive_winbar = {
                lualine_b = { { "filename", path = 1 } },
            },
        },
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach", config = true },
        },
    },
    "jose-elias-alvarez/null-ls.nvim",

    "hrsh7th/nvim-cmp",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    { "saadparwaiz1/cmp_luasnip" },
    "L3MON4D3/LuaSnip",

    -- DAP
    { "mfussenegger/nvim-dap" },
    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
            ensure_installed = { "codelldb" },
            handlers = {},
        },
        event = "VeryLazy",
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            local dap, dapui = require "dap", require "dapui"
            dapui.setup()
            vim.keymap.set("n", "<leader>du", function()
                dapui.toggle()
            end, { desc = "[D]ebugger toggle [U]I" })
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
        event = "VeryLazy",
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = { style = "moon", transparent = true },
    },

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
                vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "[H]unk [U]ndo stage" })
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
            require("colorizer").setup()
        end,
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    -- My Plugins
    {
        dir = "~/Code/vim-pixem",
        cmd = "Pixem",
        config = [[vim.g.pixem_use_rem = 1]],
    },
}
