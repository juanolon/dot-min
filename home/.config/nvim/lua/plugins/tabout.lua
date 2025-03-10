return {
    {
        'abecodes/tabout.nvim',
        opt = true,  -- Set this to true if the plugin is optional
        event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
        enalbed = false,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            {
                tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                completion = true, -- if the tabkey is used in a completion pum
            }
        }
    },
}
