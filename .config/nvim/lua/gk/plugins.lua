require("packer").startup {
    function(use)
        use "wbthomason/packer.nvim"
        -- use "~/Code/packer.nvim"
        use "lewis6991/impatient.nvim"

        use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require "gk.treesitter"]] }
        use { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" }
        use "JoosepAlviste/nvim-ts-context-commentstring"

        use { "numToStr/Comment.nvim", event = "BufRead", config = [[require"gk.comment"]] }
        use { "windwp/nvim-autopairs", config = [[require("nvim-autopairs").setup()]] }
        use "tpope/vim-surround"
        use { "lukas-reineke/indent-blankline.nvim", config = [[require("gk.indentline")]] }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = [[require "gk.telescope"]],
        }
        use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
        use "nvim-telescope/telescope-file-browser.nvim"
        use "jvgrootveld/telescope-zoxide"
        use "kyazdani42/nvim-web-devicons"

        -- LSP
        use { "jose-elias-alvarez/null-ls.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" } }
        use { "neovim/nvim-lspconfig", config = [[require "gk.lsp"]] }
        use "ray-x/lsp_signature.nvim"

        use { "hrsh7th/nvim-cmp", config = [[require "gk.completion"]] }
        use "onsails/lspkind-nvim"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-buffer"
        use "saadparwaiz1/cmp_luasnip"

        use { "L3MON4D3/LuaSnip", config = [[require "gk.luasnip"]] }
        use "rafamadriz/friendly-snippets"

        -- DAP
        use { "mfussenegger/nvim-dap", config = [[require "gk.dap"]] }

        -- Colorschemes
        use "folke/tokyonight.nvim"
        use "EdenEast/nightfox.nvim"
        use "mhartington/oceanic-next"
        use "joshdick/onedark.vim"
        use "arcticicestudio/nord-vim"
        use "jacoborus/tender.vim"

        use "tpope/vim-eunuch"
        use "tpope/vim-sleuth"
        use "tpope/vim-fugitive"
        use {
            "lewis6991/gitsigns.nvim",
            requires = "nvim-lua/plenary.nvim",
            event = "BufReadPre",
            config = [[require("gitsigns").setup()]],
        }

        -- use "mattn/emmet-vim"
        use { "norcalli/nvim-colorizer.lua", config = [[require("colorizer").setup()]] }
        use { "dstein64/vim-startuptime", cmd = "StartupTime" }

        -- My Plugins
        use { "~/Code/vim-pixem", cmd = "Pixem", config = [[vim.g.pixem_use_rem = 1]] }
    end,
    config = {
        -- profile = {
        --     enable = true,
        --     threshold = 0,
        -- },
        -- log = { level = "debug" },
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    },
}
