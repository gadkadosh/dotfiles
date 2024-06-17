return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        local actions = require("telescope.actions")

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
        }
        pcall(require("telescope").load_extension, "fzf")

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
    end,
}
