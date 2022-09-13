vim.keymap.set("c", "<C-A>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-P>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-N>", "<Down>", { noremap = true })
vim.keymap.set("c", "<C-H>", "<Left>", { noremap = true })
vim.keymap.set("c", "<C-L>", "<Right>", { noremap = true })

vim.keymap.set("i", "jj", "<ESC>", { noremap = true })
vim.keymap.set("t", "jj", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("n", "<CR>", "v:hlsearch ? ':nohlsearch<CR>' : '<CR>'", { noremap = true, expr = true })
vim.keymap.set("n", "<leader>,", "<C-^>", { noremap = true })
vim.keymap.set("n", "[q", ":cprevious<CR>", { noremap = true })
vim.keymap.set("n", "]q", ":cnext<CR>", { noremap = true })

vim.keymap.set("n", "<leader>ev", ":edit $MYVIMRC<CR>", { noremap = true })
vim.keymap.set("n", "<leader>el", ":source $MYVIMRC<CR>", { noremap = true })
vim.keymap.set("n", "<leader>x", ":lua require'gk.mappings'.execute_file()<CR>", { noremap = true })

vim.keymap.set("n", "<C-h>", "<C-W>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-W>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-W>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-W>l", { noremap = true })

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
