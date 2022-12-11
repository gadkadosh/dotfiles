local ok, luasnip = pcall(require, "luasnip")
if not ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

vim.keymap.set("i", "<C-j>", "<cmd>lua require'luasnip'.expand_or_jump()<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })
vim.keymap.set("s", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { noremap = true, silent = true })
vim.keymap.set("s", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })
