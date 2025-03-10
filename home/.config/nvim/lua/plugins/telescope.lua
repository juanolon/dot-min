local actions = function(actions)
    return function(...)
        require("telescope.actions")[actions](...)
    end
end

return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
            -- 'nvim-telescope/telescope-ui-select.nvim',
        },

        keys = {
            {
                '<C-b>',
                '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr><CR>',
                'Telescope buffers'
            },
            {
                '<C-t>',
                '<cmd>Telescope find_files<CR>',
                'Telescope find_files'
            },
            {
                '<C-s>',
                '<cmd>Telescope live_grep<CR>',
                'Telescope find files'
            },
            -- {
            --     '<leader>o',
            --     '<cmd>Telescope lsp_document_symbols<CR>',
            --     'Telescope document symbold'
            -- }
        },
        init = function ()
            require("telescope").load_extension('fzf')
            require("telescope").load_extension('ui-select')
            require("telescope").load_extension('find_template')
        end,
        opts = {
            defaults = {
                -- Your defaults config goes in here
                mappings = {
                    i = {
                        ["<C-j>"] = actions("move_selection_next"),
                        ["<C-k>"] = actions("move_selection_previous"),
                        ["<esc>"] = actions("close"),
                    },
                    n = {
                        ["<C-j>"] = actions("move_selection_next"),
                        ["<C-k>"] = actions("move_selection_previous"),
                        ["<esc>"] = actions("close"),
                    }
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case"
                },
                previewer = true,
            },
            pickers = {
                buffers ={
                    theme = "dropdown",
                }
            },
            extensions = {
                luasnip = {
                    preview  = {
                        check_mime_type  = true
                    },
                },
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }
    },
    {
        'debugloop/telescope-undo.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        keys = {
            {
                '<leader>u',
                '<cmd>Telescope undo <CR>',
                'Telescope undo'
            },
        },
        opts = {
            extensions = {
                undo = {
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
        end,
    },
    {
        'benfowler/telescope-luasnip.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        keys = {
            {
                '<leader>S',
                '<cmd>Telescope luasnip<CR>',
                'Telescope luasnip'
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension('luasnip')
        end,
    },
}
