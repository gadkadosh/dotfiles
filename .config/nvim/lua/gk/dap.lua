local dap = require "dap"

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

dap.adapters.python = {
    type = "executable",
    command = "python3",
    args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch",
        program = "${file}",
        pythonPath = function()
            return "python3"
        end,
        console = "integratedTerminal",
    },
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
vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>lua require'dap.ui.variables'.scopes()<CR>", { silent = true })
