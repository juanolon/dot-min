return {
    {
        "chrisgrieser/nvim-scissors",
        disabled = true,
        -- dependencies = "nvim-telescope/telescope.nvim",
        opts = {
            snippetDir = vim.fn.stdpath("config") .. "/snippets",
        }
    },
}
