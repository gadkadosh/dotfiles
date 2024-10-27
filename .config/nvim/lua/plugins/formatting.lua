return {
    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                css = { "prettierd", stop_after_first = true },
                html = { "prettierd" },
                htmldjango = { "prettierd" },
                javascript = { "prettierd", stop_after_first = true },
                javascriptreact = { "prettierd", stop_after_first = true },
                typescriptreact = { "prettierd", stop_after_first = true },
                python = { "black" },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
            vim.keymap.set({ "n", "v" }, "<leader>f",
                function() require("conform").format({ lsp_format = "fallback" }) end)
        end,
    },
}
