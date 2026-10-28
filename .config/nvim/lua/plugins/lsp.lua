return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = { "pyrefly", "lua_ls", "eslint", "tailwindcss", "tsc", "gopls" },
                automatic_enable = false,
            },
        },
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        vim.lsp.config("pyright", {
            before_init = function(_, config)
                local root = config.root_dir

                local function get_python_path()
                    local possible_paths = { "backend/venv", "venv", ".venv" }
                    for _, path in ipairs(possible_paths) do
                        local python_path = root .. "/" .. path .. "/bin/python"
                        if vim.fn.executable(python_path) == 1 then
                            return python_path
                        end
                    end
                    return vim.fn.exepath("python3") or vim.fn.exepath("python")
                end

                config.settings.python.pythonPath = get_python_path()
            end,
        })

        vim.lsp.config("clangd", {
            root_dir = function(bufnr, on_dir)
                if vim.fs.root(bufnr, "Package.swift") then
                    return -- Let SourceKit-LSP handle this package.
                end

                on_dir(
                    vim.fs.root(bufnr, vim.lsp.config.clangd.root_markers)
                        or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
                )
            end,
        })

        vim.lsp.enable({
            "clangd",
            "eslint",
            "gopls",
            "lua_ls",
            "pyrefly",
            "sourcekit",
            "tailwindcss",
            "tsc",
        })

        local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = highlight_group,
            callback = function(event)
                local clients = vim.lsp.get_clients({
                    bufnr = event.buf,
                    method = "textDocument/documentHighlight",
                })
                if #clients > 0 then
                    vim.lsp.buf.document_highlight()
                end
            end,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "LspDetach" }, {
            group = highlight_group,
            callback = function(event)
                vim.lsp.util.buf_clear_references(event.buf)
            end,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
            callback = function(event)
                vim.keymap.set("n", "gd", function()
                    require("fzf-lua").lsp_definitions()
                end, { buffer = event.buf, desc = "[G]o to [D]efinition" })
                vim.keymap.set(
                    "n",
                    "gD",
                    vim.lsp.buf.declaration,
                    { buffer = event.buf, desc = "[G]o to [D]eclaration" }
                )
                vim.keymap.set("n", "grr", function()
                    require("fzf-lua").lsp_references()
                end, { buffer = event.buf })
            end,
        })
    end,
}
