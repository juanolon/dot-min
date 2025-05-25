return {
    {
        "zbirenbaum/copilot.lua",
        event = 'InsertEnter',
        cmd = 'Copilot',
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = true, auto_trigger = false },
            panel = { enabled = false },
            copilot_node_command = vim.fn.expand("$HOME") .. "/.config/nvm/versions/node/v22.14.0/bin/node",
            filetypes = {
                markdown = true,
                help = true,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'BlinkCmpCompletionMenuOpen',
                callback = function()
                    require("copilot.suggestion").dismiss()
                    vim.b.copilot_suggestion_hidden = true
                end,
            })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'BlinkCmpCompletionMenuClose',
                callback = function()
                    vim.b.copilot_suggestion_hidden = false
                end,
            })
        end
    }
}
