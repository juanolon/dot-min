local ls = require("luasnip")
local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

local decorator = {
    snippetType="autosnippet",
    wordTrig = false,
    regTrig = true,
}
local sr = ls.extend_decorator.apply(ls.snippet, decorator)

return
  {
    s({trig="bb", name = "bold"},
      fmta( [[ \textbf{<>} ]],
        { d(1, get_visual) }
      )
    ),
    sr(
      {
        trig = "(%a+)bb",
        name = "bold",
        desc = "<word>bb",
      },
      f(function(_, snip)
        return string.format("\\textbf{%s} ", snip.captures[1])
      end, {})
    ),
    s({trig="ii", name = "italic"},
      fmta( [[ \textit{<>} ]],
        { d(1, get_visual) }
      )
    ),
    sr(
      {
        trig = "(%a+)ii",
        name = "italic",
        desc = "<word>ii",
      },
      f(function(_, snip)
        return string.format("\\textit{%s} ", snip.captures[1])
      end, {})
    ),
    s({trig="uu", name = "underline"},
      fmta( [[ \underline{<>} ]],
        { d(1, get_visual) }
      )
    ),
    sr(
      {
        trig = "(%a+)uu",
        name = "underline",
        desc = "<word>uu",
      },
      f(function(_, snip)
        return string.format("\\underline{%s} ", snip.captures[1])
      end, {})
    ),
  }
