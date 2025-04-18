return {
    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                css = { "prettier", stop_after_first = true },
                html = { "prettier" },
                htmldjango = { "prettier" },
                javascript = { "prettier", stop_after_first = true },
                javascriptreact = { "prettier", stop_after_first = true },
                json = { "prettier", stop_after_first = true },
                jsonc = { "prettier", stop_after_first = true },
                typescript = { "prettier", stop_after_first = true },
                typescriptreact = { "prettier", stop_after_first = true },
                python = { "black" },
                yaml = { "prettier" }
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
            vim.keymap.set({ "n", "v" }, "<leader>f",
                function() require("conform").format({ lsp_format = "fallback" }) end)
        end,
    },
}
