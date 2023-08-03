local ok, dap = pcall(require, "dap")
if not ok then
    return
end

dap.defaults.fallback.terminal_win_cmd = "belowright 10new"

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

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
}

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebugger start or [C]ontinue" })
vim.keymap.set("n", "<leader>ds", dap.terminate, { desc = "[D]ebugger [S]trp" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debugger step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debugger step into" })
vim.keymap.set("n", "<F11>", dap.step_out, { desc = "Debugger step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle [D]ebugger [B]reakpoint" })
