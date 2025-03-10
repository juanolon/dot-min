return {
    {
        "mfussenegger/nvim-lint",
        dependencies = {
            -- "williamboman/mason.nvim",
            -- "rshkarin/mason-nvim-lint"
        },
        -- Event to trigger linters
        -- events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>l",
                function()
                    require("lint").try_lint()
                end,
                mode = "",
                desc = "Lint buffer",
            },
        },
        config = function()
            local lint = require("lint")

            -- mypy: show error codes
            local mypy = require('lint').linters.mypy
            mypy.args = {
                    '--show-column-numbers',
                    '--show-error-end',
                    -- '--hide-error-codes',
                    '--hide-error-context',
                    '--no-color-output',
                    '--no-error-summary',
                    '--no-pretty',
                }

            lint.linters_by_ft = {
                python = { "mypy" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    }
}
