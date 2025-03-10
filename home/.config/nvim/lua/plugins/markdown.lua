return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
        ft = { 'markdown' },
        opts = {
            -- sign = {
            --     enabled = false
            -- },
            -- ⅠⅡⅢⅣⅤⅥ
            -- ⅰⅱⅲⅳⅴⅵ
            -- ①②③④⑤⑥
            -- headings = { 'Ⅰ ', 'Ⅱ ', 'Ⅲ ', 'Ⅳ ', 'Ⅴ ', 'Ⅵ ' },
            heading = {
                enabled = true,
                icons = {'ⅰ ', 'ⅱ ', 'ⅲ ', 'ⅳ ', 'ⅴ ', 'ⅵ '},
                sign = false
            },
            -- headings = { '① ', '② ', '③ ', '④ ', '⑤ ', '⑥ ' },
            dash = {
                enabled = true,
                icons = '—',
            },
            bullet = {
                enabled = true,
                icons = { '●', '○', '◆', '◇' },
            },
            -- ☐☑☒
            -- ❏ ❎
            checkbox = {
                enabled = true,
                    unchecked = {
                        icon = '☐',
                    },
                    checked = {
                        icon = '☒',
                    }
            },
            quote = {
                enabled = true,
                icon = '┃',
            },
            pipe_table = {
                enabled = true,
                style = 'normal',
            },
            link = {
                enabled = true,
                image = ' ',
                hyperlink = ' ',
            },
            latex = {
                enabled = false,
            },
            code = {
                -- Turn on / off code block & inline code rendering
                enabled = true,
                -- Turn on / off any sign column related rendering
                sign = true,
                -- Determines how code blocks & inline code are rendered:
                --  none: disables all rendering
                --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
                --  language: adds language icon to sign column if enabled and icon + name above code blocks
                --  full: normal + language
                style = 'full',
                -- Amount of padding to add to the left of code blocks
                left_pad = 0,
                -- Determins how the top / bottom of code block are rendered:
                --  thick: use the same highlight as the code body
                --  thin: when lines are empty overlay the above & below icons
                border = 'thin',
                -- Used above code blocks for thin border
                above = '▄',
                -- Used below code blocks for thin border
                below = '▀',
                -- Highlight for code blocks & inline code
                highlight = 'ColorColumn',
            },
        }
    }
}
