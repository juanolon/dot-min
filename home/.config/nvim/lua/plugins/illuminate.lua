return {
    {
        'RRethy/vim-illuminate',
        event = "VeryLazy",
        config = function ()
            require('illuminate').configure({
                disable_keymaps = true
            })
        end,
        keys = {
            {
                '<Tab>',
                ':lua require("illuminate").goto_next_reference()<cr>',
                'Jump to next reference'
            },
            {
                '<S-Tab>',
                ':lua require("illuminate").goto_prev_reference()<cr>',
                'Jump to previous reference'
            },
        }
    },
}

