vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- package loading
    -- use { "lewis6991/impatient.nvim", config = [[require('impatient')]] }
    use { "wbthomason/packer.nvim", opt = true }

    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp",
        config = function() 
            require('config.luasnip')
            -- -- load snippets from friendly-snippets
            -- require("luasnip.loaders.from_vscode").lazy_load()

            -- -- load snippets in folder snippets (honza)
            -- -- require("luasnip.loaders.from_snipmate").lazy_load()
        end,
    })

    -----------------------
    --Autocompletion
    -----------------------
    use { "hrsh7th/nvim-cmp", config = [[require('config.nvim-cmp')]], after = { 'nvim-treesitter', 'LuaSnip' }}
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-omni", after = "nvim-cmp" }
    -- use { "dcampos/cmp-snippy", after = "nvim-cmp" }
    use { 'saadparwaiz1/cmp_luasnip', after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }
    use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }
    use { "dmitmel/cmp-cmdline-history", after = "nvim-cmp" }
    use { "micangl/cmp-vimtex", after = "nvim-cmp" }
    use { "juanolon/cmp-luasnip-choice", after={"nvim-cmp", "LuaSnip"}, config = function()
        require('cmp_luasnip_choice').setup({
            auto_open = true,
        })
    end}

    use { "zbirenbaum/copilot.lua", config = function()
        require("copilot").setup({
            suggestion = { enabled = true, auto_trigger = false },
            panel = { enabled = false },
        })
        vim.cmd [[
            autocmd BufReadPre *
                \ let f=getfsize(expand("<afile>"))
                \ | if f > 100000 || f == -2
                \ | let b:copilot_enabled = v:false
                \ | endif
        ]]
    end}
    use { "zbirenbaum/copilot-cmp", after = { "copilot.lua" }, config = function()
        require("copilot_cmp").setup()
    end}

    -- TODO: do i need this? i have wilder. or is something different?
    -- use {"vzze/cmdline.nvim"}

    -- use { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" }
    -- use { "kdheepak/cmp-latex-symbols", after = "nvim-cmp", ft={"tex", "markdown", "python"} }

    -- LSP
    use { "williamboman/mason.nvim" }
    -- use { "williamboman/mason-lspconfig.nvim" }
    --https://github.com/gbrlsnchs/telescope-lsp-handlers.nvim
    use { 'neovim/nvim-lspconfig',
        config = [[require('config.lsp')]],
        after = "cmp-nvim-lsp",
        -- requires = {{ "glepnir/lspsaga.nvim" }}
    }
    -- TODO
    use { 'rachartier/tiny-inline-diagnostic.nvim', config = function()
        require('tiny-inline-diagnostic').setup()
    end}

    -----------------------
    -- COLORSCHEMES
    -----------------------
    --[[ use { "kvrohit/mellow.nvim" }
    use { "EdenEast/nightfox.nvim" } ]]
    -- use { "NLKNguyen/papercolor-theme" } -- nice
    -- use { "Verf/deepwhite.nvim", config = function()
    --     -- vim.cmd [[colorscheme deepwhite]]
    -- end, } -- light
    -- use { "Mofiqul/adwaita.nvim", config = function()
    --     -- vim.cmd [[colorscheme adwaita]]
    -- end}
    use { "rose-pine/neovim", config = function()
        require("rose-pine").setup({})
        vim.cmd [[colorscheme rose-pine]]
    end }
    -- use { "deparr/tairiki.nvim", config = function()
    --     -- require('tairiki').setup {
    --     -- -- optional configuration here
    --     -- }
    --     -- require('tairiki').load() -- only necessary to use as default theme, has same behavior as ':colorscheme tairiki'
    -- end}
    -- use { "timofurrer/edelweiss", config = function()
    --     -- vim.cmd([[colorscheme edelweiss]])
    -- end, rtp = "/nvim"}

    -- use { "rebelot/kanagawa.nvim" , config = function() 
    --         -- local default_colors = require("kanagawa.colors").setup()


    --         require'kanagawa'.setup({
    --             overrides = function(colors)
    --             local theme = colors.theme

    --             return {
    --                 -- create a new hl-group using default palette colors and/or new ones
    --                 IlluminatedWordText = { fg = theme.fujiWhite, bg = theme.sumiInk3 },
    --                 IlluminatedWordRead = { fg = theme.fujiWhite, bg = theme.sumiInk3 },
    --                 IlluminatedWordWrite = { fg = theme.fujiWhite, bg = theme.sumiInk3 },
    --             }

    --             end,
    --             -- theme = 'wave'
    --         })
    --         -- vim.cmd("colorscheme kanagawa")
    --     end
    -- }

    -----------------------
    -- UIs
    -----------------------
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = [[require('config.statusline')]],
    }

    use { "AndreM222/copilot-lualine" }

    -- marks
    use { 'chentoast/marks.nvim', config = function()
        require('marks').setup({
            default_mappings = true,
            signs = true
        })
        end
    }
    -- notifications
    use {
      "rcarriga/nvim-notify",
      event = "BufEnter",
      config = function()
        vim.defer_fn(function()
          require("config.nvim-notify")
        end, 2000)
      end,
    }

    -- use 'anuvyklack/hydra.nvim' 
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {}
        end
    }

    use { "levouh/tint.nvim", config = function() 
        require("tint").setup()
    end}

    -----------------------
    -- FUZZY
    -----------------------
    use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}

    -- telescope
    use {
      "nvim-telescope/telescope.nvim",
      -- cmd = "Telescope",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = [[ require('config.telescope') ]]
    }
    use {
        'benfowler/telescope-luasnip.nvim',
        requires = { 'nvim-telescope/telescope.nvim' }
    }
    use {
        'debugloop/telescope-undo.nvim',
        requires = { 'nvim-telescope/telescope.nvim' }
    }
    -- use telescope for vim.ui.select
    use {'nvim-telescope/telescope-ui-select.nvim' }

    -- popup. nice to have. need configuration
    -- use { 'carbon-steel/detour.nvim',
    --     config = function ()
    --         vim.keymap.set('n', '<c-w><enter>', ":Detour<cr>")
    --     end
    -- }
    use {
        "gelguy/wilder.nvim",
        config = [[ require('config.wilder')]]
        , run = 'UpdateRemotePlugins' }

    -----------------------
    --UTILS
    -----------------------

    -- add/delete/change surroundings
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require "nvim-surround".setup({})
        end
    })

    -- adds more jumps. like dn(
    use { 'wellle/targets.vim' }

    -- highlight words
    use { 'lfv89/vim-interestingwords' }

    -- highlights same words using lsp
    use { 'RRethy/vim-illuminate'}

    use { 'm4xshen/autoclose.nvim', config = function()
        require("autoclose").setup()
    end}
    -- auto close. TODO: search alternative?
    -- use { "windwp/nvim-autopairs", config = [[require('config.nvim-autopairs')]] }
    --
    -- jumpt out of autoclose. not working
    use { "abecodes/tabout.nvim", config = function()
        require("tabout").setup({
            tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
            backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
            completion = true, -- if the tabkey is used in a completion pum
        })
    end, wants = {'nvim-treesitter'},
        after = {'nvim-cmp'}
    }
    -- auto close tags (html, xml..)
    -- treesitter html tags
    -- TODO: enable nvim-ts-autotag in config/treesitter.lua autotag: enable: true
    -- use { "windwp/nvim-ts-autotag" }

    -- intelligen comments
    use{ 'b3nj5m1n/kommentary', config = function() 
            require('kommentary.config').configure_language("default", {
                prefer_single_line_comments = true,
            })
        end 
    }

    use { 'brenoprata10/nvim-highlight-colors', config = function()
        require('nvim-highlight-colors').setup({})
    end
    }

    use { 'HakonHarnes/img-clip.nvim' }

    use { 'dstein64/vim-startuptime' }

    use {"folke/todo-comments.nvim", config = function()
        require('todo-comments').setup({
            signs = true,
            keywords = {
                TODO = { icon = "T", color = "todo" },
                INFO = { icon = "I", color = "info" },
                DONE = { icon = "D", color = "done" },
                CHECK = { icon = "C", color = "check" },
                TEST = { icon = "TT", color = "test" },
            },
            colors = {
                todo = { "#FF8C00" },
                info = { "#0C7C59" },
                done = { "#521d63" },
                check = { "#CA686B" },
                test = { "#c345e9" },
            },
            merge_keywords = true,
            highlight = {
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "fg", -- "fg" or "bg" or empty
                keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
            },
            pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        })
    end
    }

    -----------------------
    --File Type
    -----------------------
    -- treesitter
    -- if run doesn't work,plugin path:
    -- .local/share/nvim/site/pack/packer/opt/nvim-treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
        run = ':TSUpdate',
      -- run = { "cargo install tree-sitter-cli", ":TSUpdate" },
      config = [[require('config.treesitter')]],
    }

    -- latex filetyp
    use { 'lervag/vimtex', setup = [[require('config.vimtex')]] }

    -- jupyter control
    -- use { "kiyoon/jupynium.nvim", run = "pip3 install --user .", config = function()
    --     require("jupynium").setup({
    --         default_notebook_URL = "localhost:8888/nbclassic",
    --         -- default_notebook_URL = "localhost:8888",
    --         auto_start_server = {
    --             enable = false,
    --             file_pattern = { "*.sync.*" },
    --         },
    --         auto_start_ju = {
    --             enable = false,
    --             file_pattern = { "*.sync.*", "*.md" },
    --         },
    --         jupynium_file_pattern = { "*.sync.*" },
    --         jupyter_command = "/home/juanolon/.pyenv/shims/jupyter",
    --         use_default_keybindings = false,
    --     })
    -- end
    -- }
    use { 'untitled-ai/jupyter_ascending.vim',
        config = function()
            vim.keymap.set('n', '<Leader>x', '<Plug>JupyterExecute')
            vim.keymap.set('n', '<Leader>X', '<Plug>JupyterExecuteAll')
        end
    }

    use { 'ray-x/go.nvim', config = function()
        require('go').setup()

        local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require('go.format').goimports()
            end,
            group = format_sync_grp,
        })
    end}

    -- open ipynb
    use { 'goerz/jupytext.vim', config = function()
            vim.g['jupytext_fmt'] = 'py:percent' -- custom s:jupytext_extension_map
            vim.g['jupytext_to_ipynb_opts'] = '--to=py:percent'
            vim.g['jupytext_filetype_map'] = "{'md': 'tex'}"

            vim.g['jupytext_print_debug_msgs'] = 0
        end
    }

    -- use { 'jmbuhr/otter.nvim', config = [[require('config.otter')]] }

    -- flutter
    use { 'dart-lang/dart-vim-plugin' }
    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = function()
            require('telescope').load_extension("flutter")
        end
    }

    -- rust
    use { 'simrat39/rust-tools.nvim' }

    -- zettelkasten
    use { 'zk-org/zk-nvim', config = [[require('config.zk-nvim')]] }

    -- markdown
    -- use { 'preservim/vim-markdown', config = function()
    --     vim.g['vim_markdown_math'] = 1
    --     vim.g['vim_markdown_folding_disabled'] = 1
    --     vim.g['vim_markdown_math'] = 1
    --     vim.g['vim_markdown_frontmatter'] = 1
    --     vim.g['vim_markdown_new_list_item_indent'] = 1
    --     vim.g['vim_markdown_edit_url_in'] = 'tab'
    -- end
    -- }

    -- see config in lsp.lua
    -- use { 'vigoux/ltex-ls.nvim', requires = 'neovim/nvim-lspconfig'}

    -- lua port: kaymmm/bullets.nvim
    -- TODO: activate this again. but now, testing with standard inka syntax
    -- use { 'bullets-vim/bullets.vim', config = function()
    --     vim.g['bullets_delete_last_bullet_if_empty'] = 1
    --     vim.g['bullets_line_spacing'] = 1
    --     -- vim.g['bullets_renumber_on_change'] = 0
    -- end}
    -- use { 'tadmccorkle/markdown.nvim', 
    --     config = function()
    --         require("markdown").setup({
    --             -- configuration here or empty for defaults
    --         })
    --     end}

    use ({ 'MeanderingProgrammer/markdown.nvim',
        after = { 'nvim-treesitter' },
        as = 'render-markdown',
        config = function()
            require('render-markdown').setup({

                -- ⅠⅡⅢⅣⅤⅥ
                -- ⅰⅱⅲⅳⅴⅵ
                -- ①②③④⑤⑥
                -- headings = { 'Ⅰ ', 'Ⅱ ', 'Ⅲ ', 'Ⅳ ', 'Ⅴ ', 'Ⅵ ' },
                headings = { 'ⅰ ', 'ⅱ ', 'ⅲ ', 'ⅳ ', 'ⅴ ', 'ⅵ ' },
                -- headings = { '① ', '② ', '③ ', '④ ', '⑤ ', '⑥ ' },
                dash = '—',
                -- Character to use for the bullet points in lists
                bullets = { '●', '○', '◆', '◇' },
                -- ☐☑☒
                checkbox = {
                    -- Character that will replace the [ ] in unchecked checkboxes
                    unchecked = '☐ ',
                    -- Character that will replace the [x] in checked checkboxes
                    checked = '☒ ',
                },
                -- Character that will replace the > at the start of block quotes
                quote = '┃',
                table_style = 'normal',
            })
        end,
    })

end)
