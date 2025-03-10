local ls = require("luasnip")
local u = require('utils')
local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

local decorator = {
    snippetType = "autosnippet",
    condition = u.pipe({ u.in_mathzone })
}

local s = ls.extend_decorator.apply(ls.snippet, decorator)
local regDeco = {
    snippetType = "autosnippet",
    wordTrig = false,
    regTrig = true,
    condition = u.pipe({ u.in_mathzone }),
}
local sr = ls.extend_decorator.apply(ls.snippet, regDeco)

return {
        sr(
            {
                trig = "(%a+)bb",
                name = "bold",
                desc = "<word>bb",
                priority=2000,
            },
            f(function(_, snip)
                return string.format("\\boldsymbol{%s}", snip.captures[1])
            end, {})
        ),
        s({trig="bb", name = "bold"},
            fmta( [[\boldsymbol{<>}]],
                { d(1, get_visual) }
            )
        ),
        s({trig="ii", name = "Mathcal"},
        fmta( [[\mathcal{<>}]],
            { d(1, get_visual) }
        )
        ),
        sr(
        {
            trig = "(%a+)ii",
            name = "Mathcal",
            desc = "<word>ii",
        },
        f(function(_, snip)
            return string.format("\\mathcal{%s}", snip.captures[1])
        end, {})
        ),
        s({trig="tt", name = "Text"},
        fmta( [[\text{<>}]],
            { d(1, get_visual) }
        )
        ),
        sr(
        {
            trig = "(%a+)tt",
            name = "Text",
            desc = "<word>tt",
        },
        f(function(_, snip)
            return string.format("\\text{%s}", snip.captures[1])
        end, {})
        ),
        s({ trig = "stt", name = "text subscript" },
        f(function(_, snip)
            return string.format("\\_text{%s}", snip.captures[1])
        end, {})
        ),

        s({ trig = "Ex", name = "Expectation" }, {
            t("\\mathbb{E}")
        }),
        s({ trig = "OO", name = "emptyset"}, {
            t("\\O"),
        }),
        s({ trig = "RR", name = "R" }, {
            t("\\mathbb{R}")
        }),
        s({ trig = "QQ", name = "Q" }, {
            t("\\mathbb{Q}")
        }),
        s({ trig = "ZZ", name = "Z" }, {
            t("\\mathbb{Z}")
        }),
        s({ trig = "UU", name = "cup" }, {
            t("\\cup ")
        }),
        s({ trig = "NN", name = "n" }, {
            t("\\mathbb{N}")
        }),
        s({ trig = "bmat", name = "bmat" }, fmta([[
            \begin{bmatrix}
            <>
            \end{bmatrix}<>
                ]],
            {
                i(1),
                i(2),
            })
        ),
        s({ trig = "pmat", name = "pmat" }, fmta([[
            \begin{pmatrix}
            <>
            \end{pmatrix}<>
                ]],
            {
                i(1),
                i(2),
            })
        ),
        s({ trig = "uuu", name = "bigcup" }, {
            t("\\bigcup_{${1:i \\in ${2: I}}} $0")
        }),
        s({ trig = "DD", name = "D" }, {
            t("\\mathbb{D}")
        }),
        s({ trig = "HH", name = "H" }, {
            t("\\mathbb{H}")
        }),
        s({ trig = "lll", name = "l" }, {
            t("\\ell")
        }),
    }
