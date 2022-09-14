local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local null_ls = require "null-ls"

null_ls.setup {
    on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup_format,
                buffer = 0,
                callback = function()
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black.with {
            prefer_local = ".venv/bin",
        },
        null_ls.builtins.diagnostics.flake8.with {
            prefer_local = ".venv/bin",
            cwd = function(params)
                return require("lspconfig").util.root_pattern "setup.cfg"(params.bufname)
            end,
        },
        null_ls.builtins.diagnostics.stylelint.with {
            only_local = "node_modules/.bin",
        },
    },
}
