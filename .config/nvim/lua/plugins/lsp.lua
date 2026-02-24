return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = { "pyright", "lua_ls", "eslint", "ts_ls", "tailwindcss" },
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

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
            callback = function(event)
                vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

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
    end,
}
