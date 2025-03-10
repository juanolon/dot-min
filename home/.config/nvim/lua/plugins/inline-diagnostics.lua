local colors = require("rose-pine.palette")

return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        opts = {
            preset = "simple",
            -- signs = {
            --     left = "",
            --     right = ""
            -- },
            hi = {
                -- background = colors.base,
                -- mixing_color = colors.base
                -- background = 'Normal',
                -- mixing_color = 'None'
            },
        }
    }
}
