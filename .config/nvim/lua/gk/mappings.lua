vim.api.nvim_set_keymap("c", "<C-P>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-N>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true })
vim.api.nvim_set_keymap("n", "<CR>", "v:hlsearch ? ':nohlsearch<CR>' : '<CR>'", { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "<leader>s", ':let @+=@"<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>,", "<C-^>", { noremap = true })
vim.api.nvim_set_keymap("n", "[q", ":cprevious<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>ev", ":edit $MYVIMRC<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>el", ":source $MYVIMRC<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>x", ":lua require'gk.mappings'.execute_file()<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-W>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-W>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W>l", { noremap = true })

local M = {}
M.execute_file = function()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")
    if ft == "lua" then
        vim.cmd [[ luafile % ]]
    elseif ft == "python" then
        vim.cmd [[ !python3 % ]]
    elseif ft == "vim" then
        vim.cmd [[ source % ]]
    end
end

return M
