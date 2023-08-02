local ok, dap = pcall(require, "dap")
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

dap.configurations.c = dap.configurations.cpp

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

vim.keymap.set("n", "<F5>", function()
    require("dap").continue()
end)
vim.keymap.set("n", "<S-F5>", function()
    require("dap").terminate()
end)
vim.keymap.set("n", "<F10>", function()
    require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
    require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
    require("dap").step_out()
end)
vim.keymap.set("n", "<leader>b", function()
    require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>B", function()
    require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end)
vim.keymap.set("n", "<leader>lp", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
end)
