local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
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
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "css", "html", "javascript", "json", "lua", "python" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            }
        end,
    },
    { "windwp/nvim-autopairs",  config = true },
    { "windwp/nvim-ts-autotag", config = true },
    "tpope/vim-surround",

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            local actions = require "telescope.actions"

            require("telescope").setup {
                defaults = {
                    mappings = {
                        n = {
                            ["q"] = actions.close,
                            ["<c-k>"] = actions.delete_buffer,
                        },
                        i = {
                            ["<c-k>"] = actions.delete_buffer,
                        },
                    },
                    winblend = 10,
                    sorting_strategy = "ascending",
                    path_display = { truncate = 2 },
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.5,
                        },
                        height = 0.8,
                    },
                },
                pickers = {
                    find_files = {
                        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
                    },
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                    },
                },
            }
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "file_browser")

            local builtin = require "telescope.builtin"

            vim.keymap.set("n", "<leader><enter>", builtin.buffers)
            vim.keymap.set("n", "<leader>a", builtin.live_grep)
            vim.keymap.set("n", "<leader>ga", builtin.grep_string)
            vim.keymap.set("n", "<leader>t", builtin.find_files)
            vim.keymap.set("n", "<leader>ev", function()
                return builtin.find_files {
                    prompt_title = "Neovim Config",
                    cwd = vim.fn.stdpath "config",
                }
            end)
            vim.keymap.set("n", "<leader>o", builtin.oldfiles)
            vim.keymap.set("n", "<leader>?", builtin.help_tags)
            vim.keymap.set("n", "<leader>f", function()
                require("telescope").extensions.file_browser.file_browser {
                    path = "%:p:h",
                }
            end)
        end,
    },

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
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
        },
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
    },

    {
        "hrsh7th/nvim-cmp",
        -- event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            local cmp = require "cmp"
            local luasnip = require "luasnip"
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert {
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-y>"] = cmp.mapping.confirm { select = true },
                    ["<C-d>"] = cmp.mapping.scroll_docs(-1),
                    ["<C-f>"] = cmp.mapping.scroll_docs(1),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                },
                formatting = {
                    format = require("lspkind").cmp_format {
                        maxwidth = 40,
                        menu = {
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[NVIM]",
                            luasnip = "[Snippet]",
                            path = "[Path]",
                            buffer = "[Buffer]",
                        },
                    },
                },
                experimental = {
                    ghost_text = true,
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "buffer",                 keyword_length = 3 },
                },
            }
        end,
    },
    -- DAP
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            {
                "jay-babu/mason-nvim-dap.nvim",
                opts = {
                    ensure_installed = { "codelldb" },
                    handlers = {},
                },
                event = "VeryLazy",
            },
        },
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
        config = function()
            require("tokyonight").setup {
                style = "moon",
                transparent = true,
            }
            vim.cmd.colorscheme "tokyonight"
        end,
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
            vim.opt.termguicolors = true
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
