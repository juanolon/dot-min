local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    s({trig="pf", name="Print", desc="print"},
      fmta(
        [[
        print(f"<>: {<>}")<>
        ]],
        {
            i(1, "desc"),
            i(2, "var"),
            i(3),
        }
      )
    )
  }
