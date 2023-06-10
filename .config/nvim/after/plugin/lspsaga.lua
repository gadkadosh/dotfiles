local ok, lspsaga = pcall(require, "lspsaga")
if not ok then
    return
end

lspsaga.setup {
    ui = {
        border = 'rounded'
    },
    rename = {
        in_select = false
    },
    lightbulb = {
        sign = false
    },
}

local opts = { noremap = true }

vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
