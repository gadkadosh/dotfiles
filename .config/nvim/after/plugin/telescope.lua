local telescope = require "telescope"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

telescope.setup {
    defaults = require("telescope.themes").get_dropdown {
        mappings = {
            n = {
                ["q"] = actions.close,
            },
        },
        winblend = 10,
        layout_config = {
            width = 0.8,
            horizontal = {
                preview_width = 0.5,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
    },
}

pcall(telescope.load_extension, "file_browser")

local neovim_config = function()
    return builtin.find_files {
        prompt_title = "Neovim Config",
        cwd = vim.fn.stdpath "config",
        hidden = true,
    }
end

local neovim_plugins = function()
    return builtin.find_files {
        prompt_title = "Neovim Plugins",
        path_display = { truncate = 3 },
        cwd = vim.fn.stdpath "data" .. "/site/pack/packer",
    }
end

local lsp_references = function()
    builtin.lsp_references {
        fname_width = 50,
        trim_text = true,
    }
end

local map_telescope = function(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { noremap = true })
end

map_telescope("<leader><enter>", builtin.buffers)
map_telescope("<leader>a", builtin.live_grep)
map_telescope("<leader>ga", builtin.grep_string)
map_telescope("<leader>gr", lsp_references)
map_telescope("<leader>t", builtin.find_files)
map_telescope("<leader>f", telescope.extensions.file_browser.file_browser)
map_telescope("<leader>o", builtin.oldfiles)
map_telescope("<leader>?", builtin.help_tags)
map_telescope("<leader>ev", neovim_config)
map_telescope("<leader>ep", neovim_plugins)
