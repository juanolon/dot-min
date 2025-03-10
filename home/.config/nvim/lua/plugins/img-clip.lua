return {
    'HakonHarnes/img-clip.nvim',
    event = "VeryLazy",
    ft = { "markdown", "latex" },
    opts = {
        dir_path = '.',
        relative_to_current_file = true,
    },
    keys = {
            {
                "<leader>P",
                function()
                    require('img-clip').paste_image({relative_to_current_file= true, dir_path='.'})
                end,
                desc = "Paste image from system clipboard",
            },
    },
}
