return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            -- 'vigoux/ltex-ls.nvim',
            'hrsh7th/nvim-cmp',
            'saghen/blink.cmp',
            'williamboman/mason-lspconfig.nvim',
            {
                'williamboman/mason.nvim',
                cmd = 'Mason',
                build = ':MasonUpdate',
                opts = {
                    ui = {
                        border = 'rounded',
                        width = 0.7,
                        height = 0.8,
                    },
                },
            },
        },
        config = function()
            local lspconfig = require 'lspconfig'
            local function capabilities()
                local caps = vim.tbl_deep_extend(
                    'force',
                    vim.lsp.protocol.make_client_capabilities(),
                    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
                    require('cmp_nvim_lsp').default_capabilities()
                -- require('blink.cmp').get_lsp_capabilities()
                )
                caps.textDocument.formatting = nil
                caps.textDocument.rangeFormatting = nil
                -- caps.textDocument.documentFormattingProvider = nil
                -- caps.textDocument.documentRangeFormattingProvider = nil
                return caps
            end

            require('lspconfig.ui.windows').default_options.border = 'rounded'

            vim.lsp.config("phpactor", {
                init_options = {
                    ["language_server_completion.trim_leading_dollar"] = true,
                },
            })

            vim.lsp.config("pyright", {
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            ignore = { '*' },
                        },
                    },
                },
            })
            vim.lsp.config("ts_ls", {
                filetypes = {
                    "typescript", "typescriptreact", "typescript.tsx"
                },
                cmd = { "typescript-language-server", "--stdio" }
            })

            vim.lsp.config("lua_ls", {
                on_init = function(client)
                    local path = client.workspace_folders
                        and client.workspace_folders[1]
                        and client.workspace_folders[1].name
                    if
                        not path
                        or not (
                            vim.uv.fs_stat(path .. '/.luarc.json')
                            or vim.uv.fs_stat(path .. '/.luarc.jsonc')
                        )
                    then
                        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT',
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME,
                                        '${3rd}/luv/library',
                                    },
                                },
                            },
                        })
                        client.notify(
                            vim.lsp.protocol.Methods.workspace_didChangeConfiguration,
                            { settings = client.config.settings }
                        )
                    end

                    return true
                end,
                settings = {
                    Lua = {
                        -- Using stylua for formatting.
                        format = { enable = false },
                        hint = {
                            enable = true,
                            arrayIndex = 'Disable',
                        },
                        completion = { callSnippet = 'Replace' },
                    },
                },
            })

            vim.lsp.config("*", {
                -- on_attach = on_attach,
                capabilities = capabilities(),
            })

            require('mason-lspconfig').setup {
                ensure_installed = {
                    'bashls',
                    'eslint',
                    'jsonls',
                    'lua_ls',
                    -- css modules
                    'cssmodules_ls',
                    'cssls',
                    -- go
                    'gopls',
                    -- python
                    'pyright',
                    -- 'mypy',
                    -- 'black',
                    'ruff',
                    -- rust
                    'rust_analyzer',
                    -- latex
                    'texlab',
                    'ltex', -- language tool grammar/spelling erros for latex/markdown
                    -- web
                    'phpactor',
                    'ts_ls',
                    -- 'prettierd',
                    -- phpcbf
                    'angularls',
                    -- 'harper_ls',
                    --
                    -- notes
                    -- 'zk',
                    -- linting
                    -- 'efm',
                } }
        end,
    }
}
