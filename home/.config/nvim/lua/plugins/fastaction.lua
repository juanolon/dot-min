return {
    {
        'Chaitanyabsprip/fastaction.nvim',
        event = "VeryLazy",
        opts = {
            keys = "asdfghlzxcvbnm",
            register_ui_select = true,
            -- override_function = function(params) -- to retain built-in style keymaps
            --     params.invalid_keys[#params.invalid_keys + 1] = tostring(#params.invalid_keys + 1)
            --     return { key = tostring(#params.invalid_keys), order = 0 }
            -- end,
        }
    }
}
