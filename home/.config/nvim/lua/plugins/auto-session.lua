return {
    {
        -- TODO alternative: https://github.com/Shatur/neovim-session-manager
        'rmagatti/auto-session',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        event = "VeryLazy",
        keys = {
            {
                '<leader>sl',
                '<cmd>Telescope session-lens<CR>',
                'Restore sessions'
            },
            {
                '<leader>ss',
                '<cmd>SessionSave<CR>',
                'Save sessions'
            },
        },
        config = function()
            require('auto-session').setup({
                log_level = 'error',
                auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },

                -- ⚠️ This will only work if Telescope.nvim is installed
                -- The following are already the default values, no need to provide them if these are already the settings you want.
                session_lens = {
                    -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                    load_on_setup = true,
                    theme_conf = { border = true },
                    previewer = false,
                    buftypes_to_ignore = {}, -- list of buffer types that should not be deleted from current session when a new one is loaded
                },
            })
        end,
    },
}
