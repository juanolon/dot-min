return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            -- 'vigoux/ltex-ls.nvim',
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
                    -- require('cmp_nvim_lsp').default_capabilities(),
                    require('blink.cmp').get_lsp_capabilities()
                )
                caps.textDocument.formatting = nil
                caps.textDocument.rangeFormatting = nil
                -- caps.textDocument.documentFormattingProvider = nil
                -- caps.textDocument.documentRangeFormattingProvider = nil
                return caps
            end

            require('lspconfig.ui.windows').default_options.border = 'rounded'

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
                    'ltex',   -- language tool grammar/spelling erros for latex/markdown
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
                },
                handlers = {
                    function(server)
                        lspconfig[server].setup { capabilities = capabilities() }
                    end,
                    pyright = function()
                        lspconfig.pyright.setup {
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
                        }
                    end,
                    -- texlab = function()
                    --     lspconfig.texlab.setup {
                    --         settings = {
                    --             texlab = {
                    --                 build = {
                    --                     args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc", "-shell-escape" },
                    --                     forwardSearchAfter = true,
                    --                     onSave = true
                    --                 },
                    --                 forwardSearch = {
                    --                     executable = "zathura",
                    --                     args = { "--synctex-forward", "%l:1:%f", "%p" },
                    --                 },
                    --             },
                    --         }
                    --     }
                    -- end,
                    -- zk = function()
                    --     lspconfig.zk.setup {
                    --         default_config = {
                    --             cmd = { 'zk', 'lsp' },
                    --             filetypes = { 'markdown' },
                    --             root_dir = function()
                    --                 return lspconfig.util.root_pattern('.zk')
                    --             end,
                    --             settings = {}
                    --         }
                    --     }
                    -- end,
                    harper_ls = function ()
                        lspconfig.harper_ls.setup {
                            settings = {
                                ["harper-ls"] = {
                                    fileDictPath = "~/.config/harper-ls/file_dictionaries/",
                                    -- defaults
                                    linters = {
                                        spell_check = true,
                                        spelled_numbers = false,
                                        an_a = true,
                                        sentence_capitalization = true,
                                        unclosed_quotes = true,
                                        wrong_quotes = false,
                                        long_sentences = true,
                                        repeated_words = true,
                                        spaces = true,
                                        matcher = true,
                                        correct_number_suffix = true,
                                        number_suffix_capitalization = true,
                                        multiple_sequential_pronouns = true,
                                        linking_verbs = false,
                                        avoid_curses = true,
                                        terminating_conjunctions = true
                                    },
                                    codeActions = {
                                        forceStable = true
                                    }
                                }
                            },
                        }
                    end,
                    -- gopls = function ()
                    --     local cfg = require'go.lsp'.config()
                    --     lspconfig.gopls.setup(cfg)
                    -- end,
                    ts_ls = function()
                        lspconfig.ts_ls.setup {
                            filetypes = {
                                "typescript", "typescriptreact", "typescript.tsx"
                            },
                            cmd = { "typescript-language-server", "--stdio" }
                        }
                    end,
                    lua_ls = function ()
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities(),
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
                        }
                    end,
                    jsonls = function()
                        lspconfig.jsonls.setup {
                            capabilities = capabilities(),
                            settings = {
                                json = {
                                    validate = { enable = true },
                                    format = { enable = true },
                                },
                            },
                            -- Lazy-load schemas.
                            on_new_config = function(config)
                                config.settings.json.schemas = config.settings.json.schemas or {}
                                vim.list_extend(config.settings.json.schemas, require('schemastore').json.schemas())
                            end,
                        }
                    end,
                    ltex = {
                        enabled = { "bibtex", "gitcommit", "markdown", "org", "tex", "restructuredtext", "rsweave", "latex", "quarto", "rmd", "context", "mail", "plaintext" }
                    },
                    -- ltex = function ()
                        -- require'ltex-ls'.setup {
                        --     on_attach = on_attach,
                        --     capabilities = capabilities(),
                        --     filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
                        --     use_spellfile = false, -- Uses the value of 'spellfile' as an external file when checking the document
                        --     window_border = 'single', -- How the border should be rendered
                        --     settings = {
                        --         ltex = {
                        --             enabled = { "latex", "tex", "bib", "markdown", },
                        --             language = "auto",
                        --             dictionary = (function()
                        --                 -- For dictionary, search for files in the runtime to have
                        --                 -- and include them as externals the format for them is
                        --                 -- dict/{LANG}.txt
                        --                 --
                        --                 -- Also add dict/default.txt to all of them
                        --                 local files = {}
                        --                 for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
                        --                     local lang = vim.fn.fnamemodify(file, ":t:r")
                        --                     local fullpath = vim.fs.normalize(file, ":p")
                        --                     files[lang] = { ":" .. fullpath }
                        --                 end
                        --
                        --                 if files.default then
                        --                     for lang, _ in pairs(files) do
                        --                         if lang ~= "default" then
                        --                             vim.list_extend(files[lang], files.default)
                        --                         end
                        --                     end
                        --                     files.default = nil
                        --                 end
                        --                 return files
                        --             end)(),
                        --         }
                        --     }
                        -- }
                    -- end
                    -- efm = function ()
                    --     local languages = {
                    --         lua = {
                    --             require('efmls-configs.formatters.stylua'),
                    --         },
                    --         python = {
                    --             -- using ruff_lsp
                    --             -- require('efmls-configs.formatters.ruff'),
                    --             -- require('efmls-configs.linters.ruff'),
                    --             require('efmls-configs.linters.mypy')
                    --         }
                    --     }
                    --
                    --     lspconfig.efm.setup {
                    --         filetypes = vim.tbl_keys(languages),
                    --         settings = {
                    --             rootMarkers = { '.git/' },
                    --             languages = languages,
                    --         },
                    --         init_options = {
                    --             documentFormatting = true,
                    --             documentRangeFormatting = true,
                    --         },
                    --     }
                    -- end
                },
            }

        end,
    },
}
