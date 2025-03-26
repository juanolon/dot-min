return {
    {
        "chrisgrieser/nvim-scissors",
        enabled = false,
        -- dependencies = "nvim-telescope/telescope.nvim",
        opts = {
            snippetDir = vim.fn.stdpath("config") .. "/snippets",
        }
    },
}
