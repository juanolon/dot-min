return {
    {
        'saghen/blink.cmp',
        enabled = false,
        dependencies = {
            -- {
            --     'saghen/blink.compat',
            --     lazy = true,
            -- },
            -- {
            --     "zbirenbaum/copilot-cmp",
            --     dependencies = "copilot.lua",
            --     config = true,
            -- },
            'giuxtaposition/blink-cmp-copilot',
            'L3MON4D3/LuaSnip'
        },
        lazy = false,
        version = 'v1.1.1',
        opts = {
            keymap = {
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-e>'] = { 'hide' },
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-l>'] = { 'select_and_accept' },

                -- ['<Tab>'] = {
                --     function()
                --         return require('luasnip').choice_active() and require('luasnip').change_choice(1)
                --     end,
                --     'fallback'
                -- },
                ['<Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
            },
            sources = {
                default = { 'lsp', 'snippets', 'copilot', 'path', 'buffer', 'cmdline' },
                providers = {
                    copilot = {
                        name = 'copilot',
                        module = 'blink-cmp-copilot',
                        -- score_offset = -3,
                    },
                    -- markdown = {
                    --     name = 'RenderMarkdown',
                    --     module = 'render-markdown.integ.blink',
                    --     fallbacks = { 'lsp' },
                    -- },
                    lsp = {
                        min_keyword_length = 0,
                    },
                },
                min_keyword_length = 0,
            },
            completion = {
                keyword = { range = 'full' },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
                trigger = {
                    show_in_snippet = false,
                    show_on_trigger_character = true,
                },
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    border = 'single',
                    draw = {
                        treesitter = {'lsp'},
                    },
                },
                documentation = {
                    auto_show = true,
                    window = {
                        border = 'single',
                    }
                },
            },
            signature = {
                enabled = true,
                window = {
                    border = 'single',
                }
            },
            snippets = { preset = 'luasnip' },
            -- snippets = {
            --     expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
            --     active = function(filter)
            --         if filter and filter.direction then
            --             return require('luasnip').jumpable(filter.direction)
            --         end
            --         return require('luasnip').in_snippet()
            --     end,
            --     jump = function(direction) require('luasnip').jump(direction) end,
            -- },
            appearance = {
                highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = false,
                kind_icons = {
                    Text = '  ',
                    Method = '  ',
                    Function = '  ',
                    Constructor = '  ',
                    Field = '  ',
                    Variable = '  ',
                    Class = '  ',
                    Interface = '  ',
                    Module = '  ',
                    Property = '  ',
                    Unit = '  ',
                    Value = '  ',
                    Enum = '  ',
                    Keyword = '  ',
                    Snippet = '  ',
                    Color = '  ',
                    File = '  ',
                    Reference = '  ',
                    Folder = '  ',
                    EnumMember = '  ',
                    Constant = '  ',
                    Struct = '  ',
                    Event = '  ',
                    Operator = '  ',
                    TypeParameter = '  ',
                    Copilot = '  ',
                    zk = 'z ',
                },
            },
        }
    }
}
