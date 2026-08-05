return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- "nvim-neotest/nvim-nio",
        -- "rcarriga/nvim-dap-ui",
        "jay-babu/mason-nvim-dap.nvim",
        {
            "igorlfs/nvim-dap-view",
            opts = {
                windows = {
                    size = 0.45,
                    position = "right",
                },
            },
        },
    },
    config = function()
        local dap = require("dap")
        -- local dap, dapui = require("dap"), require("dapui")
        -- dapui.setup()
        dap.defaults.fallback.terminal_win_cmd = "belowright 10new"

        dap.adapters.debugpy = function(callback, config)
            callback({
                type = "server",
                host = config.connect.host,
                port = config.connect.port,
            })
        end

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        }

        dap.configurations.cpp = {
            {
                name = "Debug current file",
                type = "codelldb",
                request = "launch",
                program = function()
                    local file = vim.fn.expand("%:p")
                    local executable = vim.fn.expand("%:p:r")

                    local cmd = {
                        "clang++",
                        "-g",
                        file,
                        "-o",
                        executable,
                    }

                    local result = vim.system(cmd):wait()
                    if result.code ~= 0 then
                        error("Compilation failed:\n" .. (result.stderr or ""))
                    end

                    return executable
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            },
        }

        -- dap.configurations.objc = {
        --     {
        --         name = "Debug current file",
        --         type = "codelldb",
        --         request = "launch",
        --         program = function()
        --             local file = vim.fn.expand("%:p")
        --             local executable = vim.fn.expand("%:p:r")
        --
        --             local cmd = {
        --                 "clang",
        --                 "-framework",
        --                 "Foundation",
        --                 "-g",
        --                 file,
        --                 "-o",
        --                 executable,
        --             }
        --
        --             local result = vim.system(cmd):wait()
        --             if result.code ~= 0 then
        --                 error("Compilation failed:\n" .. (result.stderr or ""))
        --             end
        --
        --             return executable
        --         end,
        --         cwd = "${workspaceFolder}",
        --         stopOnEntry = false,
        --         args = {},
        --     },
        -- }

        -- vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint" })
        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "DapBreakpointRejected" })
        -- vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "debugPC", numhl = "debugPC" })

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
            "<F21>",
            function()
                vim.ui.input({ prompt = "Condition? " }, function(input)
                    require("dap").set_breakpoint(input)
                end)
            end,
            desc = "Debug: Set Breakpoint",
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
