return {
    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                css = { { "prettierd" } },
                html = { "prettierd" },
                htmldjango = { "prettierd" },
                javascript = { { "prettierd" } },
                javascriptreact = { { "prettierd" } },
                typescriptreact = { { "prettierd" } },
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
