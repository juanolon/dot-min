local function feedkey(key, mode)
    vim.fn.feedkeys(vim.keycode(key), mode or vim.api.nvim_get_mode().mode)
end

return {
    {
        'L3MON4D3/LuaSnip',
        opts = function()
            local types = require 'luasnip.util.types'

            return {
                -- Display a cursor-like placeholder in unvisited nodes
                -- of the snippet.
                ext_opts = {
                    [types.insertNode] = {
                        unvisited = {
                            virt_text = { { '|', 'Conceal' } },
                            virt_text_pos = 'inline',
                        },
                    },
                    [types.exitNode] = {
                        unvisited = {
                            virt_text = { { '|', 'Conceal' } },
                            virt_text_pos = 'inline',
                        },
                    },
                },

                -- Don't store snippet history for less overhead
                history = false,
                -- Allow autotrigger snippets
                enable_autosnippets = true,
                update_events = 'TextChanged,TextChangedI',
                -- For equivalent of UltiSnips visual selection
                store_selection_keys = "<Tab>",
                -- Event on which to check for exiting a snippet's region
                region_check_events = 'InsertEnter',
                delete_check_events = 'InsertLeave',
            }
        end,
        config = function(_, opts)
            local luasnip = require 'luasnip'

            luasnip.setup(opts)

            -- Use <C-c> to select a choice in a snippet.
            vim.keymap.set({ 'i', 's' }, '<C-c>', function()
                if luasnip.choice_active() then
                    require 'luasnip.extras.select_choice'()
                end
            end, { desc = 'Select choice' })
            vim.keymap.set('', '<Leader>U', '<Cmd>lua require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets/"})<CR><Cmd>echo "Snippets refreshed!"<CR>')
            vim.keymap.set({ "i", "s" }, "<Tab>", function()
                return luasnip.locally_jumpable() and luasnip.jump(1) or feedkey("<Tab>", "n")
            end, { desc = "Luasnip - Jump to next node" })

            vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
                return luasnip.in_snippet() and luasnip.jumpable(-1) and luasnip.jump(-1) or feedkey("<S-Tab>", "n")
            end, { desc = "Luasnip - Jump to previous node" })

            require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets/"})
            -- require("luasnip.loaders.from_vscode").lazy_load()


            -- open choices automatically, when a choice is entered
            -- vim.api.nvim_create_autocmd("User", {
            --         pattern = "LuasnipChoiceNodeEnter",
            --         callback = function()
            --                 if require("luasnip").choice_active() then
            --                         require "luasnip.extras.select_choice"()
            --                 end
            --                 -- print(require("luasnip").session.event_node)
            --                 -- print "hmm"
            --         end,
            -- })
            -- show sign when a choice is availale
            vim.fn.sign_define("LuasnipSignChoiceNode", {
                text = "",
                texthl = "LuasnipChoiceNode",
            })

            local group = vim.api.nvim_create_augroup("config.plugins.luasnip.choice", {})
            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "LuasnipChoiceNodeEnter",
                callback = function(a)
                    vim.fn.sign_place(
                        0,
                        "config.plugins.luasnip.choice",
                        "LuasnipSignChoiceNode",
                        a.buf,
                        {
                            lnum = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[1],
                        }
                    )
                end,
            })
            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "LuasnipChoiceNodeLeave",
                callback = function(a)
                    vim.fn.sign_unplace("config.plugins.luasnip.choice", {
                        buffer = a.buf,
                    })
                end,
            })

        end,
    },
}
