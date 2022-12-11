local ok, dap = pcall( require, "dap")
if not ok then
    return
end

dap.defaults.fallback.terminal_win_cmd = "belowright 10new"

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

dap.adapters.lldb = {
    type = "executable",
    command = "lldb-vscode",
    name = "lldb",
}

local cpp_program
dap.configurations.cpp = {
    {
        type = "lldb",
        request = "launch",
        name = "Launch",
        program = function()
            if cpp_program ~= nil then
                print("Executing: " .. cpp_program)
                return cpp_program
            end
            cpp_program = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            return cpp_program
        end,
        cwd = "${workspaceFolder}",
    },
}

local get_python_path = function()
    local venv_path = os.getenv "VIRTUAL_ENV"
    if venv_path then
        return venv_path .. "/bin/python"
    end
    return "python3"
end

dap.adapters.python = function(cb, config)
    if config.request == "launch" then
        cb {
            type = "executable",
            command = get_python_path(),
            args = { "-m", "debugpy.adapter" },
        }
    else
        cb {
            type = "server",
            host = "127.0.0.1",
            port = 5678,
        }
    end
end

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch",
        program = "${file}",
        console = "integratedTerminal",
    },
    -- {
    --     type = "python",
    --     request = "launch",
    --     name = "Django runserver",
    --     program = vim.fn.getcwd() .. "/manage.py",
    --     args = { "runserver" },
    --     console = "integratedTerminal",
    -- },
    -- {
    --     type = "python",
    --     request = "attach",
    --     name = "Attach to Django",
    --     host = "127.0.0.1",
    --     port = 5678,
    -- },
}

vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<S-F5>", "<cmd>lua require'dap'.terminate()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>B",
    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>lp",
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    { silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>lb", "<cmd>lua require'dap'.list_breakpoints()<CR>:copen<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>di", "<cmd>lua require'dap.ui.widgets'.hover()<CR>", { silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>ds",
    "<cmd>lua require'dap.ui.widgets'.sidebar(require'dap.ui.widgets'.scopes).open()<CR>",
    { silent = true }
)
