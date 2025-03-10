local ls = require('luasnip')

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 20
local MIN_LABEL_WIDTH = 20
local MENU_WIDTH_MAX = 20

-- codicons symbols
local cmp_kinds = {
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
}


return {
    {
        'hrsh7th/nvim-cmp',
        enabled = false,
        dependencies = {
            "L3MON4D3/LuaSnip",
            {
                "zbirenbaum/copilot-cmp",
                dependencies = "copilot.lua",
                config = true,
                -- config = function(_, opts)
                --     local copilot_cmp = require("copilot_cmp")
                --     copilot_cmp.setup(opts)
                --     -- attach cmp source whenever copilot attaches
                --     -- fixes lazy-loading issues with the copilot cmp source
                --     LazyVim.lsp.on_attach(function(client)
                --         copilot_cmp._on_insert_enter({})
                --     end, "copilot")
                -- end,
            },
            -- TODO check plugins
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            -- "hrsh7th/cmp-omni",
            'saadparwaiz1/cmp_luasnip',
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",
            -- "micangl/cmp-vimtex",
            -- still doesnt work
            -- {
            --     "L3MON4D3/cmp-luasnip-choice",
            --     opts = {auto_open = true}
            -- }
            },
                version = false,
                event = 'InsertEnter',
                opts = function()
                    local defaults = require 'cmp.config.default'()
                    local luasnip = require 'luasnip'
                    local cmp = require 'cmp'
                    -- local symbol_kinds = require('icons').symbol_kinds

                    -- TODO:
                    -- * give module type high priority. nice for auto-import in python
                    -- * copilot completions should not be the first element
                    local compare = cmp.config.compare

                    local winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None'


                    local select_opts = {behavior = cmp.SelectBehavior.Insert}

                    local mapping_sets = {
                        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "s", "c" }),
                        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "s", "c" }),
                        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "s", "c" }),
                        ['<C-l>'] = cmp.mapping(cmp.mapping.confirm ({
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = true,
                        }), { "i", "s", "c" }),
                        ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), { "i", "s", "c" }),
                        -- ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                        --
                        ["<Tab>"] = cmp.mapping(function(fallback)
                            if ls.expand_or_locally_jumpable() then
                                ls.expand_or_jump()
                                -- elseif has_words_before() then
                                --     cmp.complete()
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
                        ["<S-Tab>"] = cmp.mapping(function(fallback)
                            if ls.jumpable(-1) then
                                ls.jump(-1)
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
                        ['<C-k>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                return cmp.select_prev_item(select_opts)
                            end

                            fallback()
                        end, {"i", "s", "c"}
                        ),
                        ['<C-j>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                return cmp.select_next_item(select_opts)
                            end

                            fallback()
                        end, {"i", "s", "c"}
                        ),
                    }

                    return {
                        snippet = {
                            expand = function(args)
                                ls.lsp_expand(args.body)
                            end,
                        },
                        window = {
                            completion = {
                                border = "single",
                                winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
                                col_offset = -5,
                                side_padding = 1,
                            },
                            documentation = {
                                border = "rounded", -- single|rounded|none
                                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None", -- BorderBG|FloatBorder
                            }
                        },
                        -- sorting = defaults.sorting,
                        sorting = {
                            comparators = {
                                compare.score,
                                compare.offset,
                                compare.recently_used,
                                compare.order,
                                compare.exact,
                                compare.kind,
                                compare.locality,
                                compare.length,
                                -- copied from TJ Devries; cmp-under
                                function(entry1, entry2)
                                    local _, entry1_under = entry1.completion_item.label:find "^_+"
                                    local _, entry2_under = entry2.completion_item.label:find "^_+"
                                    entry1_under = entry1_under or 0
                                    entry2_under = entry2_under or 0
                                    if entry1_under > entry2_under then
                                        return false
                                    elseif entry1_under < entry2_under then
                                        return true
                                    end
                                end,
                            },
                        },
	                    mapping = cmp.mapping.preset.insert(mapping_sets),
                        sources = cmp.config.sources(
                        {
                            -- { name = 'luasnip_choice'},
                        -- },
                        -- {
                            { name = 'luasnip' },
                            { name = 'nvim_lsp' },
                            { name = 'copilot' },
                            -- { name = 'vimtex'},
                            -- { name = "otter" },
                            -- { name = 'latex_symbols' }
                        }, {
                            { name = 'buffer' },
                            { name = "nvim_lsp_signature_help" },
                        }),
                        completion = {
                            completeopt = "menu,menuone,noselect,preview",
                        },
                        view = {
                            entries = {
                                name = "custom", -- custom
                            },
                        },
                        formatting = {
                            fields = { "kind", "abbr", "menu" },
                            format = function(entry, vim_item)
                                local label = vim_item.abbr
                                local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)

                                if truncated_label ~= label then
                                    vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
                                elseif string.len(label) < MIN_LABEL_WIDTH then
                                    local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
                                    vim_item.abbr = label .. padding
                                end

                                local kind = vim_item.kind
                                -- source name is the client name
                                local ok, source_name = pcall(function() return entry.source.source.client.config.name end)
                                if source_name == "zk" and kind == "Text" then
                                    kind = "zk"
                                end
                                local kind_icon = cmp_kinds[kind] or ''
                                -- show [icon] [name] [kind]
                                vim_item.kind = " " .. kind_icon .. " "

                                -- show the function import as the menu
                                -- local cmp_ctx = get_lsp_completion_context(entry.completion_item, entry.source)
                                -- if cmp_ctx ~= nil and cmp_ctx ~= "" then
                                --     vim_item.menu = cmp_ctx
                                -- else
                                --     vim_item.menu = ''
                                -- end

                                vim_item.menu = kind
                                -- max length for menu
                                local menu_width = string.len(vim_item.menu)
                                if menu_width > MENU_WIDTH_MAX then
                                    vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, MENU_WIDTH_MAX - 1)
                                    vim_item.menu = vim_item.menu .. '…'
                                else
                                    local padding = string.rep(' ', MENU_WIDTH_MAX - menu_width)
                                    vim_item.menu = padding .. vim_item.menu
                                end
                                return vim_item
                            end,
                        }
                    }
                    -- end
                    -- return {
                    --     preselect = cmp.PreselectMode.None,
                    --     formatting = {
                    --         fields = { 'kind', 'abbr', 'menu' },
                    --         format = function(_, vim_item)
                    --             local MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 25, 30
                    --             local ellipsis = require('icons').misc.ellipsis
                    --
                    --             -- Add the icon.
                    --             vim_item.kind = (symbol_kinds[vim_item.kind] or symbol_kinds.Text) .. ' ' .. vim_item.kind
                    --
                    --             -- Truncate the label.
                    --             if vim.api.nvim_strwidth(vim_item.abbr) > MAX_ABBR_WIDTH then
                    --                 vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_WIDTH) .. ellipsis
                    --             end
                    --
                    --             -- Truncate the description part.
                    --             if vim.api.nvim_strwidth(vim_item.menu or '') > MAX_MENU_WIDTH then
                    --                 vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, MAX_MENU_WIDTH) .. ellipsis
                    --             end
                    --
                    --             return vim_item
                    --         end,
                    --     },
                    --     -- window = {
                    --     --     completion = {
                    --     --         border = 'rounded',
                    --     --         winhighlight = winhighlight,
                    --     --         scrollbar = true,
                    --     --     },
                    --     --     documentation = {
                    --     --         border = 'rounded',
                    --     --         winhighlight = winhighlight,
                    --     --         max_height = math.floor(vim.o.lines * 0.5),
                    --     --         max_width = math.floor(vim.o.columns * 0.4),
                    --     --     },
                    --     -- },
                    -- }
                end,
            },
        }
