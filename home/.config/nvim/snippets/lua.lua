local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    s({trig="sn", name="Snippet", desc="add a new snippet"},
      fmta(
        [=[
        s({trig="<>", name="<>", desc="<>"<>},
        fmta(
            [[
            <>
            ]],
            {
            <>
            }
        ),
        {}
        )
        ]=],
        {
                    i(1, "trigger"),
                    i(2, "name"),
                    i(3, "desc"),
                    i(4, ", snippettype=\"autosnippet\""),
                    i(5, "body"),
                    i(6, "i()")
        }
      )
    )
  }
