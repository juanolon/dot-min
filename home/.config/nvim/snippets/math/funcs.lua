local ls = require("luasnip")
local parse_snippet = require("luasnip.util.parser").parse_snippet
local u = require('utils')

local decorator = {
    snippetType="autosnippet",
    wordTrig = false,
    condition = u.pipe({ u.in_mathzone, u.no_backslash }),
}

local parse_snippet = ls.extend_decorator.apply(parse_snippet, decorator)

return {
    parse_snippet({ trig = "arcsin", name = "arcsin" }, "\\arcsin "),
    parse_snippet({ trig = "arctan", name = "arctan" }, "\\arctan "),
    parse_snippet({ trig = "arcsec", name = "arcsec" }, "\\arcsec "),
    parse_snippet({ trig = "asin", name = "asin" }, "\\arcsin"),
    parse_snippet({ trig = "atan", name = "atan" }, "\\arctan"),
    parse_snippet({ trig = "asec", name = "asec" }, "\\arcsec"),

    parse_snippet({ trig = "set", name = "set" }, [[ \\{$1\\} $0 ]]),
    -- parse_snippet({ trig = "fun", name = "function map" }, "f \\colon $1 \\R \\to \\R \\colon $0"),

    parse_snippet(
      { trig = "abs", name = "absolute value \\abs{}" },
      "\\abs{${1:${TM_SELECTED_TEXT}}}$0"
    ),
    parse_snippet({ trig = "argmax", name = "argmax" }, "\\underset{$1}{\\operatorname{argmax}} $0"),
    parse_snippet({ trig = "argmin", name = "argmin" }, "\\underset{$1}{\\operatorname{argmin}} $0"),
--  
    parse_snippet({ trig = "max", name = "max" }, "\\underset{$1}{\\operatorname{max}} $0"),
    parse_snippet({ trig = "min", name = "min" }, "\\underset{$1}{\\operatorname{min}} $0"),
}
