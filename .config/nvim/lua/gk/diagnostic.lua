vim.diagnostic.config {
    virtual_text = { source = "if_many", prefix = "●" },
    float = { border = "rounded", source = "if_many" },
    severity_sort = true,
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>D", "<cmd>lua vim.diagnostic.setqflist()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
