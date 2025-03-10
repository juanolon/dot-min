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
    s({ trig = "not", name = "Negation" }, t("\\neg ")),
    s({ trig = "and", name = "and" }, t("\\wedge ")),
    s({ trig = "or", name = "or" }, t("\\vee ")),
    s({ trig = "And", name = "And" }, t("\\bigwedge ")),
    s({ trig = "Or", name = "Or" }, t("\\bigvee ")),

    s({ trig = "inn", name = "in" }, t("\\in ")),
    s({ trig = "EE", name = "exists" }, t("\\exists ")),
    s({ trig = "AA", name = "forall" }, t("\\forall ")),

    s({ trig = "=>", name = "implies" }, t("\\implies")),
    s({ trig = "simp", name = "short implies" }, t("\\Rightarrow")),
    s({ trig = "=<", name = "implied by" }, t("\\impliedby")),
    s({ trig = "<<", name = "<<" }, t("\\ll")),
    s({ trig = "<-", name = "", priority = 100 }, t("\\leftarrow ")),
    s({ trig = "->", name = "to", priority = 100 }, t("\\to ")),
    s({ trig = "-->", name = "long to", priority = 200 }, t("\\longrightarrow ")),
    s({ trig = "<--", name = "long from", priority = 200 }, t("\\longleftarrow ")),

    s({ trig = "iff", name = "iff" }, t("\\iff")),
    s({ trig = "siff", name = "short iff", priority = 100}, t("\\Leftrightarrow")),
}
