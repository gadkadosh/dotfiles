local on_attach = function(client, bufnr)
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    local lsp_map = function(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true })
    end

    lsp_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    lsp_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    lsp_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    lsp_map("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    lsp_map("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    lsp_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    lsp_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    lsp_map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    lsp_map("n", "<leader>p", "<cmd>lua vim.lsp.buf.formatting()<CR>")

    require("lsp_signature").on_attach { hint_enable = false }

    if client.name == "tsserver" or client.name == "jsonls" then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end

    if client.resolved_capabilities.document_formatting then
        vim.cmd [[
            augroup Format
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
        ]]
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
    debug = true,
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.flake8,
    },
    on_attach = on_attach,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = { "clangd", "pyright", "tsserver", "eslint", "jsonls", "html", "cssls", "vimls" }

for _, server in ipairs(servers) do
    require("lspconfig")[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require("lspconfig").sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
}
