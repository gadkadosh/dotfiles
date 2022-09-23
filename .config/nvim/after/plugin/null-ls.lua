local lsp = require "gk.lsp"

local null_ls = require "null-ls"

null_ls.setup {
    on_attach = lsp.create_format_autocmd,
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
