require("luasnip/loaders/from_vscode").lazy_load()

vim.api.nvim_set_keymap(
    "i",
    "<C-j>",
    "<cmd>lua require'luasnip'.expand_or_jump()<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })
