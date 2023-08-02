vim.diagnostic.config {
    virtual_text = { source = "if_many", prefix = "●" },
    float = { border = "rounded", source = "if_many" },
    severity_sort = true,
}

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>D", vim.diagnostic.setqflist)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
