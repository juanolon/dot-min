return {
    {
        'SidOfc/carbon.nvim',
        event = "VeryLazy",
        opts = {
            auto_open = false,
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("carbon").explore_left({bang = true})
                end,
                mode = "",
                desc = "Open explorer",
            },
        },
    }
}
