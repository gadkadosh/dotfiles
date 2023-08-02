local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

local servers = {
    "clangd",
    "cssls",
    "dockerls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "pyright",
    "tailwindcss",
    "tsserver",
    "lua_ls",
}

require("mason-lspconfig").setup {
    ensure_installed = servers,
}

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local augroup_lsp_highlight = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

local lsp_format = function()
    vim.lsp.buf.format {
        filter = function(client)
            return client.name == "null-ls"
        end,
    }
end

local on_attach = function(client, bufnr)
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = bufnr }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "[G]o to [D]efinition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "[G]o to [D]eclaration" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>p", lsp_format, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [Action]" })
    vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[n]ame" })

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_clear_autocmds { group = augroup_lsp_highlight, buffer = bufnr }
        vim.api.nvim_create_autocmd("CursorHold", {
            group = augroup_lsp_highlight,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = augroup_lsp_highlight,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup_format, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup_format,
            buffer = bufnr,
            callback = lsp_format,
        })
    end
end

local handler_opts = { border = "rounded" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, handler_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, handler_opts)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
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
