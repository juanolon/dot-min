local ls = require("luasnip")
local u = require("utils")
local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

local decorator = {
    snippetType="autosnippet",
    wordTrig=false,
    regTrig = true,
    condition = u.pipe({ u.in_mathzone }),
}

local s = ls.extend_decorator.apply(ls.snippet, decorator)

return {
  -- SUPERSCRIPT
  s({trig = "([%w%)%]%}])''", name = "<char|]|)>^{}", desc = "<char|]|)>''"},
    fmta(
      "<>^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  -- SUBSCRIPT
  s({trig = "([%w%)%]%}]);;", name = "<char|]|)>_{}", desc = "<char|]|)>;;"},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  -- SUBSCRIPT AND SUPERSCRIPT
  s({trig = "([%w%)%]%}])__", name = "<char|]|)>_{}^{}", desc = "<char|]|)>__"},
    fmta(
      "<>^{<>}_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2),
      }
    )
  ),
  -- TEXT SUBSCRIPT
  s({trig = 'sd'},
    fmta("_{\\mathrm{<>}}",
      { d(1, get_visual) }
    )
  ),
  -- SUPERSCRIPT SHORTCUT
  -- Places the first alphanumeric character after the trigger into a superscript.
  s({trig = '([%w%)%]%}])"([%w])', name = "<char|]|)>^{<char2>}", desc = "<char|]|)>\"<char2>"},
    fmta(
      "<>^<>",
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end ),
      }
    )
  ),
  -- SUBSCRIPT SHORTCUT
  -- Places the first alphanumeric character after the trigger into a subscript.
  s({trig = '([%w%)%]%}]):([%w])', name = "<char|]|)>_{<char2>}", desc = "<char|]|)>:<char2>"},
    fmta(
      "<>_<>",
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end ),
      }
    )
  ),
  -- ZERO SUBSCRIPT SHORTCUT
  s({trig = '([%a%)%]%}])00', name = "x_0", desc = "<word>00"},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("0")
      }
    )
  ),
    -- transpose
  s({trig = '([%a%)%]%}])T', name = "x^T", desc = "<char|]|)>T"},
    fmta(
      "<>^<>",
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("T")
      }
    )
  ),
}
