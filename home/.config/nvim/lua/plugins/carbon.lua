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
                    require("carbon").toggle_sidebar()
                end,
                mode = "",
                desc = "Open explorer",
            },
        },
    }
}
