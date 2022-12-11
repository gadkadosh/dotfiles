local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

telescope.setup {
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
        path_display = { "smart" },
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

pcall(telescope.load_extension, "fzf")
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
        cwd = vim.fn.stdpath "data" .. "/site/pack/packer",
    }
end

local lsp_references = function()
    builtin.lsp_references {
        fname_width = 180,
        show_line = false,
    }
end

local file_browser = function()
    telescope.extensions.file_browser.file_browser {
        path = "%:p:h",
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
map_telescope("<leader>f", file_browser)
map_telescope("<leader>o", builtin.oldfiles)
map_telescope("<leader>?", builtin.help_tags)
map_telescope("<leader>ev", neovim_config)
map_telescope("<leader>ep", neovim_plugins)
