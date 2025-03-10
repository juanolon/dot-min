local ls = require("luasnip")
local u = require('utils')
local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

local decorator = {
    snippetType="autosnippet",
    wordTrig = true,
    condition = u.pipe({ u.in_text }),
}

local st = ls.extend_decorator.apply(ls.snippet, decorator)

return {
    st({ trig = "mk", name = "Inline math" }, fmta([[$<>$<>]],
            {
                d(1, get_visual),
                i(2)
            }
        )
    ),
    st({ trig = "md", name = "Block math" }, fmta([[
            $$
            <>
            $$
        ]],
            {
                d(1, get_visual),
            }
        )
    ),
    s({ trig = "ali", name = "Align" }, fmta([[
            \begin{align}
            <>
            \end{align}
        ]],
            {
                d(1, get_visual),
            }
        )
    ),
}
