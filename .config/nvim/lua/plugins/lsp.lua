return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- "saghen/blink.cmp",
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        local servers = {
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
            ts_ls = {},
            eslint = {},
            tailwindcss = {},
            html = {},
            pyright = {},
            jsonls = {},
            bashls = {},
            clangd = {},
        }

        local lspconfig = require("lspconfig")
        for server, config in pairs(servers) do
            -- require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
            callback = function(event)
                vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

                vim.keymap.set("n", "gd", function()
                    -- require("telescope.builtin").lsp_definitions { fname_width = 180 }
                    require("fzf-lua").lsp_definitions()
                end, { buffer = event.buf, desc = "[G]o to [D]efinition" })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]o to [D]eclaration" })
                vim.keymap.set("n", "grr", function()
                    -- require("telescope.builtin").lsp_references { fname_width = 180 }
                    require("fzf-lua").lsp_references()
                end, { buffer = event.buf })

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
    end
}
