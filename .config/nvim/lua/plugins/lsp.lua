return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        local capabilities = vim.tbl_deep_extend("force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities())

        require("mason").setup()
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        "${3rd}/luv/library",
                                        "${3rd}/love2d/library",
                                        unpack(vim.api.nvim_get_runtime_file("", true)),
                                    },
                                },
                            },
                        },
                    })
                end,
            }
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
            callback = function(event)
                vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

                vim.keymap.set("n", "gd", function()
                    require("telescope.builtin").lsp_definitions { fname_width = 180 }
                end, { buffer = event.buf, desc = "[G]o to [D]efinition" })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]o to [D]eclaration" })
                vim.keymap.set("n", "grr", function()
                    require("telescope.builtin").lsp_references { fname_width = 180 }
                end, { buffer = event.buf })
                vim.keymap.set('n', 'grn', function()
                    vim.lsp.buf.rename()
                end, { desc = 'LSP Rename' })
                vim.keymap.set({ 'n', 'x' }, 'gra', function()
                    vim.lsp.buf.code_action()
                end, { desc = 'LSP Code Actions' })

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        local handler_opts = { border = "rounded" }
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, handler_opts)
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, handler_opts)
    end
}
