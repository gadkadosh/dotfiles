require("lspsaga").init_lsp_saga {
    border_style = "rounded",
    rename_in_select = false,
    code_action_lightbulb = {
        sign = false,
    },
    finder_action_keys = {
        open = "<CR>",
    },
}

local opts = { noremap = true }

vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
