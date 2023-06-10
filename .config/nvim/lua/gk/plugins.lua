local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup({
    "lewis6991/impatient.nvim",

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/playground",      cmd = "TSPlaygroundToggle" },
    "JoosepAlviste/nvim-ts-context-commentstring",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "windwp/nvim-ts-autotag",
    "tpope/vim-surround",
    "lukas-reineke/indent-blankline.nvim",

    -- Telescope
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- Statusline
    "nvim-lualine/lualine.nvim",

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
        },
    },
    "jose-elias-alvarez/null-ls.nvim",
    "glepnir/lspsaga.nvim",

    "hrsh7th/nvim-cmp",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",

    -- DAP
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",

    -- Colorschemes
    {
        "folke/tokyonight.nvim",
        config = function()
            require 'tokyonight'.setup { style = "moon", transparent = true }
        end
    },
    "EdenEast/nightfox.nvim",
    "mhartington/oceanic-next",
    "joshdick/onedark.vim",

    "tpope/vim-eunuch",
    "tpope/vim-sleuth",
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    "norcalli/nvim-colorizer.lua",
    { "dstein64/vim-startuptime",                 cmd = "StartupTime" },

    -- My Plugins
    {
        dir = "~/Code/vim-pixem",
        cmd = "Pixem",
        config = [[vim.g.pixem_use_rem = 1]]
    },

})
