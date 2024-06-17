return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        {
            "jay-babu/mason-nvim-dap.nvim",
            opts = {
                ensure_installed = {},
                handlers = {
                    function(config)
                        require('mason-nvim-dap').default_setup(config)
                    end, }
            },
            event = "VeryLazy",
        },
    },
    config = function()
        local dap, dapui = require "dap", require "dapui"
        dapui.setup()
        dap.defaults.fallback.terminal_win_cmd = "belowright 10new"

        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })


        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debugger start or Continue" })
        vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debugger step over" })
        vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debugger step into" })
        vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debugger step out" })
        vim.keymap.set("n", "<F6>", dap.terminate, { desc = "Debugger Stop" })
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Debugger [B]reakpoint" })
        vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "[D]ebugger toggle [U]I" })
    end,
    event = "VeryLazy",
}
