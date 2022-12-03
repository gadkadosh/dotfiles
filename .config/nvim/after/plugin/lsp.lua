local lspconfig = require "lspconfig"

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local format_document = function()
    vim.lsp.buf.format {
        timeout_ms = 2000,
        filter = function(client)
            return client.name ~= "tsserver" and client.name ~= "jsonls" and client.name ~= "html"
        end,
    }
end

local on_attach = function(client)
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { noremap = true }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>p", format_document, opts)

    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]]
    end

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup_format,
            buffer = 0,
            callback = format_document,
        })
    end
end

local handler_opts = { border = "rounded" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, handler_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, handler_opts)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
    "clangd",
    "pyright",
    "tsserver",
    "jsonls",
    "html",
    "cssls",
    "eslint",
    "vimls",
    "terraformls",
    "graphql",
    "dockerls",
}

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

lspconfig.sumneko_lua.setup {
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

local null_ls = require "null-ls"

null_ls.setup {
    on_attach = on_attach,
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.flake8.with {
            cwd = function(params)
                return require("lspconfig").util.root_pattern "setup.cfg"(params.bufname)
            end,
        },
        null_ls.builtins.diagnostics.stylelint.with {
            only_local = "node_modules/.bin",
        },
    },
}
