local ok, packer = pcall(require, "packer")
if not ok then
    return
end

packer.startup {
    function(use)
        use "wbthomason/packer.nvim"
        use "lewis6991/impatient.nvim"

        use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
        use { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" }
        use "JoosepAlviste/nvim-ts-context-commentstring"
        use "numToStr/Comment.nvim"
        use "windwp/nvim-autopairs"
        use "windwp/nvim-ts-autotag"
        use "tpope/vim-surround"
        use "lukas-reineke/indent-blankline.nvim"

        -- Telescope
        use "nvim-lua/plenary.nvim"
        use "kyazdani42/nvim-web-devicons"
        use "nvim-telescope/telescope.nvim"
        use "nvim-telescope/telescope-file-browser.nvim"
        use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

        -- Statusline
        use "nvim-lualine/lualine.nvim"

        -- LSP
        use "neovim/nvim-lspconfig"
        use "jose-elias-alvarez/null-ls.nvim"
        use "glepnir/lspsaga.nvim"

        use "hrsh7th/nvim-cmp"
        use "onsails/lspkind-nvim"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-nvim-lsp-signature-help"
        use "saadparwaiz1/cmp_luasnip"
        use "L3MON4D3/LuaSnip"

        -- DAP
        use "mfussenegger/nvim-dap"

        -- Colorschemes
        use "folke/tokyonight.nvim"
        use "EdenEast/nightfox.nvim"
        use "mhartington/oceanic-next"
        use "joshdick/onedark.vim"

        use "tpope/vim-eunuch"
        use "tpope/vim-sleuth"
        use "tpope/vim-fugitive"
        use "lewis6991/gitsigns.nvim"

        use "norcalli/nvim-colorizer.lua"
        use { "dstein64/vim-startuptime", cmd = "StartupTime" }

        -- My Plugins
        use { "~/Code/vim-pixem", cmd = "Pixem", config = [[vim.g.pixem_use_rem = 1]] }
    end,
}
