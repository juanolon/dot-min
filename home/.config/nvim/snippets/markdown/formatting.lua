local ls = require("luasnip")
local u = require('utils')
local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

local decorator = {
    snippetType="autosnippet",
    wordTrig = false,
    regTrig = true,
    condition = u.pipe({ u.in_text }),
}
local sr = ls.extend_decorator.apply(ls.snippet, decorator)

return
  {
    s({trig="bb", name = "bold"},
      fmta( [[**<>**]],
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
        return string.format("**%s**", snip.captures[1])
      end, {})
    ),
    s({trig="ii", name = "italic"},
      fmta( [[*<>*]],
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
        return string.format("*%s*", snip.captures[1])
      end, {})
    ),
    s({trig="fbi", name = "bitalic", desc = "bold and italic"},
      fmta( [[***<>***]],
        { d(1, get_visual) }
      )
    ),
    sr(
      {
        trig = "(%a+)fbi",
        name = "bold",
        desc = "<word>fbi",
      },
      f(function(_, snip)
        return string.format("***%s***", snip.captures[1])
      end, {})
    )
  }
