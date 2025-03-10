local ls = require("luasnip")
local parse_snippet = require("luasnip.util.parser").parse_snippet
local u = require('utils')

local decoration = {
    snippetType="autosnippet",
    condition = u.pipe({ u.in_mathzone }),
}
local s = ls.extend_decorator.apply(ls.snippet, decoration)

local regDeco = {
    snippetType="autosnippet",
    wordTrig = false,
    regTrig = true,
    condition = u.pipe({ u.in_mathzone }),
}
local sr = ls.extend_decorator.apply(ls.snippet, regDeco)

-- https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols
return {
    s({ trig = "set", name = "set" }, fmta([[\\{<>\\}<>]],
            { i(1), i(2) }
        )
    ),
    s({ trig = "inn", name = "in" }, t("\\in ")),
    s({ trig = "nin", name = "not in" }, t("\\notin ")),

    s({ trig = "sset", name = "Subset" }, t("\\subset ")),
    s({ trig = "ssep", name = "Superset" }, t("\\supset ")),
    s({ trig = "sseq", name = "Subset equal" }, t("\\subseteq ")),

    s({ trig = "sint", name = "Set intersection" }, t("\\cap ")),
    s({ trig = "sun", name = "Set union" }, t("\\cup ")),
    s({ trig = "smin", name = "Set difference" }, t("\\setminus ")),
    s({ trig = "sempty", name = "Empty set" }, t("\\emptyset ")),

    s({ trig = "|", name = "Divides" }, t("\\mid ")),
}

