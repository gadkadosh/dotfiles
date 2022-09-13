local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local on_attach = function(client)
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { noremap = true }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>p", vim.lsp.buf.formatting, opts)

    require("lsp_signature").on_attach { hint_enable = false }

    if
        client.name == "tsserver"
        or client.name == "jsonls"
        or client.name == "html"
        or client.name == "sumneko_lua"
    then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end

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

    if client.resolved_capabilities.document_highlight then
        vim.cmd [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]]
    end
end

local handler_opts = { border = "rounded" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, handler_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, handler_opts)

local null_ls = require "null-ls"
null_ls.setup {
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black.with {
            prefer_local = ".venv/bin",
        },
        null_ls.builtins.diagnostics.flake8.with {
            prefer_local = ".venv/bin",
        },
        null_ls.builtins.diagnostics.stylelint.with {
            prefer_local = "node_modules/.bin",
        },
    },
    on_attach = on_attach,
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { "clangd", "pyright", "tsserver", "jsonls", "html", "cssls", "eslint", "vimls" }

for _, server in ipairs(servers) do
    require("lspconfig")[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require("lspconfig").sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
}
