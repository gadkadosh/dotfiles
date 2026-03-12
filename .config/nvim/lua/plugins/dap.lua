return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- "nvim-neotest/nvim-nio",
        -- "rcarriga/nvim-dap-ui",
        "jay-babu/mason-nvim-dap.nvim",
        {
            "igorlfs/nvim-dap-view",
            opts = {
                winbar = {
                    controls = { enabled = true },
                },
            },
        },
    },
    config = function()
        local dap = require("dap")
        -- local dap, dapui = require("dap"), require("dapui")
        -- dapui.setup()
        dap.defaults.fallback.terminal_win_cmd = "belowright 10new"

        dap.adapters.python = function(callback, config)
            callback({
                type = "server",
                host = config.connect.host,
                port = config.connect.port,
            })
        end

        dap.adapters.debugpy = function(callback, config)
            callback({
                type = "server",
                host = config.connect.host,
                port = config.connect.port,
            })
        end

        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

        -- dap.listeners.before.attach.dapui_config = function()
        --     dapui.open()
        -- end
        -- dap.listeners.before.launch.dapui_config = function()
        --     dapui.open()
        -- end
        -- dap.listeners.before.event_terminated.dapui_config = function()
        --     dapui.close()
        -- end
        -- dap.listeners.before.event_exited.dapui_config = function()
        --     dapui.close()
        -- end
    end,
    keys = {
        {
            "<F1>",
            function()
                require("dap.ui.widgets").hover()
            end,
            desc = "DAP Hover",
        },
        {
            "<F5>",
            function()
                require("dap").continue()
            end,
            desc = "Debug: Start/Continue",
        },
        {
            "<F17>", -- <S-F5>
            function()
                print("terminate?")
                require("dap").terminate()
            end,
            desc = "Debug: Terminate",
        },
        {
            "<F9>",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Debug: Toggle [B]reakpoint",
        },
        {
            "<F10>",
            function()
                require("dap").step_over()
            end,
            desc = "Debugg: Step Over",
        },
        {
            "<F11>",
            function()
                require("dap").step_into()
            end,
            desc = "Debug: Step Into",
        },

        {
            "<S23>", -- <S-F11>
            function()
                require("dap").step_out()
            end,
            desc = "Debug: Step Out",
        },
        {
            "<leader>b",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Debug: Toggle [B]reakpoint",
        },
        {
            "<leader>du",
            "<cmd>DapViewToggle<CR>",
            -- function()
            --     require("dapui").toggle()
            -- end,
            desc = "Debug: Toggle UI",
        },
    },
}
