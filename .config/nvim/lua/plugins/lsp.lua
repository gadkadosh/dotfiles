return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        local lspconfig = require "lspconfig"

        local servers = {
            astro = {},
            bashls = {},
            clangd = {},
            cssls = {},
            dockerls = {},
            eslint = {},
            html = {},
            jsonls = {},
            lua_ls = {
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
            },
            pyright = {},
            rust_analyzer = {},
            tailwindcss = {},
            tsserver = {},
            htmx = {
                filetypes = { "astro" },
            },
        }

        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = servers,
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
            callback = function(event)
                vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

                local opts = { buffer = event.buf }

                vim.keymap.set("n", "gd", function()
                    require("telescope.builtin").lsp_definitions { fname_width = 180 }
                end, { buffer = event.buf, desc = "[G]o to [D]efinition" })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]o to [D]eclaration" })
                vim.keymap.set("n", "gr", function()
                    require("telescope.builtin").lsp_references { fname_width = 180 }
                end, opts)
                vim.keymap.set(
                    { "n", "v" },
                    "<leader>ca",
                    vim.lsp.buf.code_action,
                    { buffer = event.buf, desc = "[C]ode [Action]" }
                )
                vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename,
                    { buffer = event.buf, desc = "[R]e[n]ame" })

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

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        for server, config in pairs(servers) do
            lspconfig[server].setup {
                settings = config["settings"],
                filetypes = config["filetypes"],
                capabilities = capabilities,
            }
        end
    end
}
