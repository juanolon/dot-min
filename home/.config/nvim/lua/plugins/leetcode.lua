local leet_arg = "leetcode"

return {
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        lazy = leet_arg ~= vim.fn.argv()[1],
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",

            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            arg = leet_arg,
            lang = "python",
            image_support = false, -- TODO: enable this, setup 3rd/image.nvim
        },
    }
}
