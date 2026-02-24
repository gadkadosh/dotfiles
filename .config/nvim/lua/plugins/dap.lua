return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
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
    end,
    keys = {
        {
            "<F5>",
            function()
                require("dap").continue()
            end,
            { desc = "Debugger start or Continue" },
        },
        {
            "<F10>",
            function()
                require("dap").step_over()
            end,
            { desc = "Debugger step over" },
        },
        {
            "<F11>",
            function()
                require("dap").step_into()
            end,
            { desc = "Debugger step into" },
        },
        {
            "<F12>",
            function()
                require("dap").step_out()
            end,
            { desc = "Debugger step out" },
        },
        {
            "<F6>",
            function()
                require("dap").terminate()
            end,
            { desc = "Debugger Stop" },
        },
        {
            "<leader>b",
            function()
                require("dap").toggle_breakpoint()
            end,
            { desc = "Toggle Debugger [B]reakpoint" },
        },
        {
            "<leader>du",
            function()
                require("dapui").toggle()
            end,
            { desc = "[D]ebugger toggle [U]I" },
        },
    },
}
