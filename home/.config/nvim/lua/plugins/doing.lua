return {
    {
        "Hashino/doing.nvim",
        cmd = "Do",
        keys = {
            {
                "<leader>da",
                function()
                    require("doing").add()
                end,
                desc = "[D]oing: [A]dd",
            },
            {
                "<leader>de",
                function()
                    require("doing").edit()
                end,
                desc = "[D]oing: [E]dit",
            },
            {
                "<leader>dd",
                function()
                    require("doing").done()
                end,
                desc = "[D]oing: [D]dd",
            },
        },
       opts = {
            winbar = { enabled = false, },
        }
    }
}
