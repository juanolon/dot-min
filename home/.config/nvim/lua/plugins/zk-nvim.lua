return {
    {
        'zk-org/zk-nvim',
        event = "VeryLazy",
        config = function()
            require("zk").setup({
                picker = "telescope",
                lsp = {
                    -- `config` is passed to `vim.lsp.start_client(config)`
                    config = {
                        cmd = { "zk", "lsp" },
                        name = "zk",
                        auto_attach = {
                            enabled = true,
                            filetypes = { "markdown" },
                        },
                    },
                },
            }
            )
        end,
    }
}
