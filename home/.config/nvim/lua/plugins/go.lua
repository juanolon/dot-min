return {
    {
        'ray-x/go.nvim',
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
            require("go").setup(
                {
                    lsp_cfg = {
                        capabilities = capabilities,
                    },
                    -- lsp_cfg = false,
                    -- lsp_document_formatting = false,
                    lsp_keymaps = false,
                    -- lsp_codelens = false,
                    lsp_inlay_hints = {
                        enable = false
                    },
                    diagnostic = {
                        hdlr = true,
                        update_in_insert = true,
                    }
                }
            )
        end,
        -- event = {"CmdlineEnter"},
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()',
        init = function ()
            local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     pattern = "*.go",
            --     callback = function()
            --         require('go.format').goimports()
            --     end,
            --     group = format_sync_grp,
            -- })
        end
    }
}
