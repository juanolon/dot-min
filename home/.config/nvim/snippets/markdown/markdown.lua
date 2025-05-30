local ls = require("luasnip")
local u = require('utils')
local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual
local decorator = {
    condition = u.pipe({ u.in_text }),
}

local s = ls.extend_decorator.apply(ls.snippet, decorator)

return {
    s({ trig = "h1", name = "Header 1", desc = "Add header level 1" },
        fmta(
            [[
            # <>
        ]],
            {
                i(1, "title")
            }
        ),
        {}
    ),
    s({ trig = "h2", name = "Header 2", desc = "Add header level 2" },
        fmta(
            [[
          ## <>
        ]],
            {
                i(1, "title")
            }
        ),
        {}
    ),
    s({ trig = "h3", name = "Header 3", desc = "Add header level 3" },
        fmta(
            [[
          ### <>
        ]],
            {
                i(1, "title")
            }
        ),
        {}
    ),
    s({ trig = "h4", name = "Header 4", desc = "Add header level 4" },
        fmta(
            [[
          #### <>
        ]],
            {
                i(1, "title")
            }
        ),
        {}
    ),
    s({ trig = "h5", name = "Header 5", desc = "Add header level 5" },
        fmta(
            [[
          ##### <>
        ]],
            {
                i(1, "title")
            }
        ),
        {}
    ),
    s({ trig = "h6", name = "Header 6", desc = "Add header level 6" },
        fmta(
            [[
          ###### <>
        ]],
            {
                i(1, "title")
            }
        ),
        {}
    ),
    s({ trig = "codeblock", name = "Codeblock", desc = "Insert fenced code block" },
        fmta(
            [[
          ```<>
          <>
          ```
          <>
        ]],
            {
                i(1, "language"),
                i(2),
                i(3)
            }
        ),
        {}
    ),
    s({ trig = "---", name = "Horizontal rule", desc = "Insert horizontal rule" },
        fmta(
            [[
          ---
          <>
        ]],
            {
                i(1),
            }
        ),
        {}
    ),
    s({ trig = "link", name = "link" },
        fmta([[[<>](<>)<>]],
            {
                i(1, "text"),
                d(2, get_visual),
                i(3),
            }
        )
    ),
    s({
            trig     = "(https?://[%w%p%-_/%%]+)",
            regTrig  = true,
            wordTrig = false,
            name     = "autolink",
            dscr     = "Wraps a URL in [text](url)"
        },
        fmt("[{}]({})", {
            i(1, "description"),
            f(function(_, snip)
                return snip.captures[1]
            end)
        })
    ),
    -- sr(
    --     {
    --         trig = "(%a+)link",
    --         name = "link",
    --         desc = "<url>link",
    --     },
    --     f(function(_, snip)
    --         return string.format("**%s**", snip.captures[1])
    --     end, {})
    -- ),
    s({ trig = "block", name = "Blockquote", desc = "Insert a blockquote" },
        fmt(
            [[
          > {}
          {}
        ]],
            {
                i(1, "bold text"),
                i(2)
            }
        ),
        {}
    ),
    s({
            trig = "tt",
            name = "Task",
            desc = "Insert a task",
            snippetType = "autosnippet"
        },
        fmt(
            [[
          - [ ]
        ]],
            {
            }
        ),
        {}
    )
}
