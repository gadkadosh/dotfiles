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
                graphql = { "prettier" },
                html = { "prettier" },
                htmldjango = { "prettier" },
                javascript = { "prettier", stop_after_first = true },
                javascriptreact = { "prettier", stop_after_first = true },
                json = { "prettier", stop_after_first = true },
                jsonc = { "prettier", stop_after_first = true },
                lua = { "stylua" },
                typescript = { "prettier", "biome", "biome-organize-imports" },
                typescriptreact = { "prettier", "biome", "biome-organize-imports" },
                python = { "black" },
                yaml = { "prettier" },
                sql = { "sql-formatter" },
            },
            formatters = {
                biome = {
                    condition = function(ctx)
                        return vim.fs.find({ "biome.json", "biome.jsonc" }, {
                            path = ctx.filename,
                            upward = true,
                        })[1] ~= nil
                    end,
                },
                prettier = {
                    condition = function(ctx)
                        return vim.fs.find({
                            ".prettierrc",
                            ".prettierrc.json",
                            ".prettierrc.yml",
                            ".prettierrc.yaml",
                            ".prettierrc.json5",
                            ".prettierrc.js",
                            ".prettierrc.cjs",
                            "prettier.config.js",
                            "prettier.config.cjs",
                        }, {
                            path = ctx.filename,
                            upward = true,
                        })[1] ~= nil
                    end,
                },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
            vim.keymap.set({ "n", "v" }, "<leader>f", function()
                local start = vim.loop.hrtime()
                require("conform").format({ lsp_format = "fallback" })
                local elapsed = (vim.loop.hrtime() - start) / 1e6
                print(string.format("Format took %.2fms", elapsed))
            end)
        end,
    },
}
