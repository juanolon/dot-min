-- https://miguelcrespo.co/posts/debugging-javascript-applications-with-neovim/
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript-chrome
-- https://github.com/firefox-devtools/vscode-firefox-debug
-- https://github.com/mxsdev/nvim-dap-vscode-js
-- https://github.com/microsoft/vscode-js-debug
return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            -- "mxsdev/nvim-dap-vscode-js",
            -- 'jay-babu/mason-nvim-dap.nvim',
            -- 'williamboman/mason.nvim',
        },
        keys = {
            {
                "<leader>dc",
                function()
                    require 'dap'.continue()
                end,
                desc = "Debugger continue",
            },
            {
                "<leader>dso",
                function()
                    require 'dap'.step_over()
                end,
                desc = "Debugger step over",
            },
            {
                "<leader>dsi",
                function()
                    require 'dap'.step_into()
                end,
                desc = "Debugger step into",
            },
            {
                "<leader>dsO",
                function()
                    require 'dap'.step_out()
                end,
                desc = "Debugger continue",
            },
            {
                "<leader>db",
                function()
                    require 'dap'.toggle_breakpoint()
                end,
                desc = "Debugger toggle breakpoint",
            },
            {
                "<leader>dB",
                function()
                    require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
                end,
                desc = "Debugger set condi breakpoint",
            }
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
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

            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
                args = { "${port}" },
                -- executable = {
                --     command = "node",
                --     -- 💀 Make sure to update this path to point to your installation
                --     args = { "/home/juanolon/.local/share/nvim/mason/bin/js-debug-adapter", "${port}" },
                -- },
            }

            dap.adapters.php = {
                type = "executable",
                -- command = "node",
                -- args = { "php-debug-adapter" },
                command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
            }
            -- https://github.com/Alexis12119/nvim-config/blob/main/lua/plugins/dap/settings/firefox-debug-adapter.lua
            dap.adapters.firefox = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
                -- args = { "firefox-debug-adapter" },
            }

            -- set it on the project, or .vscode/launch.json
            -- dap.configurations.typescript = {
            --     {
            --         name = "Debug with Firefox",
            --         type = "firefox",
            --         request = "launch",
            --         reAttach = true,
            --         url = "http://localhost:3000",
            --         webRoot = "${workspaceFolder}",
            --         firefoxExecutable = "/usr/bin/firefox",
            --     },
            -- }
            -- dap.configurations.javascript = {
            --     {
            --         type = "pwa-node",
            --         request = "launch",
            --         name = "Launch file",
            --         program = "${file}",
            --         cwd = "${workspaceFolder}",
            --     },
            -- }
            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9000,
                },
            }
        end
    }
}
