local colors = require("rose-pine.palette")

local function lsp_func(buf)
    local error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN  })
    -- 
    return "["..error .. " ] [" .. warn .. " ]"
end

local function doing(buf)
    return " [".. require("doing").status() .. "] "
end

local function grapple(buf)
    return " [".. require("grapple").statusline() .. "] "
end

local theme2 = {
    -- current = { fg = "#cad3f5", bg = "transparent", style = "bold" },
    -- not_current = { fg = "#5b6078", bg = "transparent" },
    current = { fg = colors.rose, bg = colors.surface },
    not_current = { fg = colors.subtle, bg = colors.base },

    fill = { fg = colors.text, bg = colors.base },
}
local theme = {
    current = 'TabLineSel',
    not_current = 'TabLine',
    fill = 'TabLineFill',
}

return {
    {
        'nanozuki/tabby.nvim',
        event = 'VimEnter', -- if you want lazy load, see below
        opts = {
            line = function(line)
                return {
                    grapple(),
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.current or theme.not_current
                        return {
                            -- ⁝ ᛝ
                            line.sep("ᛝ", hl, theme.fill),
                            tab.id,
                            ': ',
                            tab.name(),
                            line.sep("ᛝ", hl, theme.fill),
                            hl = hl,
                            -- margin = ' ',
                        }
                    end),
                    line.spacer(),
                    doing(),
                    lsp_func(),
                    hl = theme.fill,
                }
            end,
        }
        -- config = function()
        --
        --     require("tabby.tabline").set(function(line)
        --         return {
        --             line.tabs().foreach(function(tab)
        --                 local hl = tab.is_current() and theme.current or theme.not_current
        --                 return {
        --                     -- ⁝ ᛝ
        --                     line.sep("ᛝ", hl, theme.fill),
        --                     tab.id,
        --                     ': ',
        --                     tab.name(),
        --                     line.sep("ᛝ", hl, theme.fill),
        --                     hl = hl,
        --                     -- margin = ' ',
        --                 }
        --             end),
        --             line.spacer(),
        --             lsp_func(),
        --             hl = theme.fill,
        --         }
        --     end)
        -- end, -- end config
    }
}
