return {
    {
        "rose-pine/neovim",
        config = function()
            require("rose-pine").setup {
                highlight_groups = {
                    -- tab line
                    TabLineSel = { fg = 'rose', bg = 'surface' },
                    TabLine = { fg = 'subtle', bg = 'base' },
                    TabLineFill = { fg = 'text', bg = 'base' },
                    -- telescope
                    TelescopeBorder = { fg = "overlay", bg = "overlay" },
                    TelescopeNormal = { fg = "subtle", bg = "overlay" },
                    TelescopeSelection = { fg = "text", bg = "highlight_med" },
                    TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
                    TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },

                    TelescopeTitle = { fg = "base", bg = "love" },
                    TelescopePromptTitle = { fg = "base", bg = "pine" },
                    TelescopePreviewTitle = { fg = "base", bg = "iris" },

                    TelescopePromptNormal = { fg = "text", bg = "surface" },
                    TelescopePromptBorder = { fg = "surface", bg = "surface" },
                },
            }
        end,
    }
}
