local colors = require("rose-pine.palette")

-- theme.normal.c.bg = colors.overlay
-- theme.insert.c.bg = colors.overlay
-- theme.visual.c.bg = colors.overlay
-- theme.replace.c.bg = colors.overlay
-- theme.command.c.bg = colors.overlay
-- theme.inactive.c.bg = colors.overlay
local pine = {
    normal = {
        a = { bg = colors.overlay, fg = colors.rose, gui = "bold" },
        b = { bg = colors.overlay, fg = colors.rose },
        c = { bg = colors.base, fg = colors.text },
    },
    insert = {
        a = { bg = colors.overlay, fg = colors.foam, gui = "bold" },
        b = { bg = colors.overlay, fg = colors.foam },
        c = { bg = colors.base, fg = colors.text },
    },
    visual = {
        a = { bg = colors.overlay, fg = colors.iris, gui = "bold" },
        b = { bg = colors.overlay, fg = colors.iris },
        c = { bg = colors.base, fg = colors.text },
    },
    replace = {
        a = { bg = colors.overlay, fg = colors.pine, gui = "bold" },
        b = { bg = colors.overlay, fg = colors.pine },
        c = { bg = colors.base, fg = colors.text },
    },
    command = {
        a = { bg = colors.overlay, fg = colors.love, gui = "bold" },
        b = { bg = colors.overlay, fg = colors.love },
        c = { bg = colors.base, fg = colors.text },
    },
    inactive = {
        a = { bg = colors.overlay, fg = colors.muted, gui = "bold" },
        b = { bg = colors.overlay, fg = colors.muted },
        c = { bg = colors.base, fg = colors.muted },
    },
}

-- ○ ◌ ◍ ◎ ● ◉ ◐ ◑ ◒ ◓ ◔ ◕
-- ⧎ ⧏ ⧐ ⧑ ⧒ ⧓ ⧔ ⧕ ⧖ ⧗
-- ※ ⁂ ⁑ ⁖ ⁘ ⁙ ⁚ ⁛ ⁜
--ᗄ ᗅ ᗆ ᗇ ᗈ ᗉ ᗊ ᗋ ᗌ ᗍ ᗎ ᗏ ᗐ ᗑ ᗒ ᗓ ᗔ ᗕ ᗖ ᗗ ᗘ ᗙ ᗚ ᗛ
--⊕ ⊖ ⊗ ⊘ ⊙ ⊚ ⊛ ⊜  ⊝
local mode = {
    -- normal
    ['n']      = { color = colors.pine, icon = "⊚"},
    ['niI']    = { color = colors.pine, icon = "⊚"},
    ['niR']    = { color = colors.pine, icon = "⊚"},
    ['niV']    = { color = colors.pine, icon = "⊚"},
    ['nt']     = { color = colors.pine, icon = "⊚"},
    ['ntT']    = { color = colors.pine, icon = "⊚"},
    -- o-pending
    ['no']     = { color = colors.pine, icon = "⊚"},
    ['nov']    = { color = colors.pine, icon = "⊚"},
    ['noV']    = { color = colors.pine, icon = "⊚"},
    ['no\22']  = { color = colors.pine, icon = "⊚"},
    -- visual
    ['v']      = { color = colors.iris, icon = "⊙"},
    ['vs']     = { color = colors.iris, icon = "⊙"},
    ['V']      = { color = colors.iris, icon = "⊙"},
    ['Vs']     = { color = colors.iris, icon = "⊙"},
    ['\22']    = { color = colors.iris, icon = "⊙"},
    ['\22s']   = { color = colors.iris, icon = "⊙"},
    -- insert
    ['i']      = { color = colors.love, icon = "⊕"},
    ['ic']     = { color = colors.love, icon = "⊕"},
    ['ix']     = { color = colors.love, icon = "⊕"},
    -- select
    ['s']      = { color = colors.rose, icon = "⊛"},
    ['S']      = { color = colors.rose, icon = "⊛"},
    ['\19']    = { color = colors.rose, icon = "⊛"},
    -- replace
    ['R']      = { color = colors.love, icon = "⊖"},
    ['Rc']     = { color = colors.love, icon = "⊖"},
    ['Rx']     = { color = colors.love, icon = "⊖"},
    ['Rv']     = { color = colors.love, icon = "⊖"},
    ['Rvc']    = { color = colors.love, icon = "⊖"},
    ['Rvx']    = { color = colors.love, icon = "⊖"},
    ['r']      = { color = colors.love, icon = "⊖"},
    -- command
    ['c']      = { color = colors.gold, icon = "⊜"},
    ['cv']     = { color = colors.gold, icon = "⊜"},
    ['ce']     = { color = colors.gold, icon = "⊜"},
    -- more
    ['rm']     = { color = colors.gold, icon = "⊜"},
    -- confirm
    ['r?']     = { color = colors.gold, icon = "⊜"},
    -- shell
    ['!']      = { color = colors.gold, icon = "⊜"},
    -- terminal
    ['t']      = { color = colors.gold, icon = "⊜"},
}

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "AndreM222/copilot-lualine"
        },
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = {
            options = {
                icons_enabled = true,
                theme = pine,
                component_separators = '',
                section_separators = {left = '', right = ''},
                disabled_filetypes = {}
            },
            sections = {
                lualine_a = {
                    {
                        function() return mode[vim.fn.mode()]['icon'] end,
                        -- color = function() return { fg = mode[vim.fn.mode()]['color'] } end,
                        padding = { right = 1, left = 1 },
                    }
                },
                -- lualine_b = {'diff'},
                -- lualine_b = { 'branch', 'diff',
                --     {
                    --         'diagnostics',
                    --         sources = { "nvim_diagnostic", "nvim_lsp" },
                    --         sections = { 'error', 'warn' },
                    --         symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
                    --     }
                    -- },
                    lualine_b = {'filename'},
                    lualine_c = {},
                    lualine_x = {
                        'lsp_progress',
                        'diff',
                        { 'copilot',
                        symbols = {
                            status = {
                                icons = {
                                    enabled = "", -- 
                                    sleep = "",   -- auto-trigger disabled
                                    disabled = " ", -- 
                                    warning = " ", -- copilot returns an error
                                    unknown = "" -- copilot is not attached/loaded
                                },
                                hl = {
                                    enabled = colors.foam,
                                    sleep = colors.subtle,
                                    disabled = colors.muted,
                                    warning = colors.love,
                                    unknown = colors.love
                                }
                            },
                            -- spinners = require("copilot-lualine.spinners").dots,
                            -- spinner_color = colors.text
                        },
                        -- show_colors = true,
                        -- show_loading = true
                    },
                    -- 'encoding', 
                },
                lualine_y = {
                    {
                        'fileformat',
                        symbols = {
                            unix = '',
                            dos = '',
                            mac = ''
                        }
                    },
                    'filetype'
                },
                lualine_z = {'progress', 'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {}
        }
    }
}
