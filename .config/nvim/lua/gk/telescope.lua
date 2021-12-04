require("telescope").setup {
    defaults = {
        winblend = 10,
        layout_config = {
            preview_width = 0.5,
        },
    },
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
    },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "zoxide")

vim.api.nvim_set_keymap("n", "<leader><enter>", "<cmd>lua require'telescope.builtin'.buffers()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua require'telescope.builtin'.live_grep()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua require'telescope.builtin'.find_files()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.file_browser()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>lua require'telescope.builtin'.oldfiles()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>?", "<cmd>lua require'telescope.builtin'.help_tags()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ev", "<cmd>lua require'gk.telescope'.neovim_config()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ep", "<cmd>lua require'gk.telescope'.neovim_plugins()<CR>", { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>cd",
    "<cmd>lua require'telescope'.extensions.zoxide.list()<CR>",
    { noremap = true }
)

local M = {}

function M.neovim_config()
    return require("telescope.builtin").find_files {
        prompt_title = "Neovim Config",
        cwd = vim.fn.stdpath "config",
        hidden = true,
    }
end

function M.neovim_plugins()
    return require("telescope.builtin").find_files {
        prompt_title = "Neovim Plugins",
        path_display = { truncate = 3 },
        cwd = vim.fn.stdpath "data" .. "/site/pack/packer",
    }
end

return M
