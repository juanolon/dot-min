# noqa: <error>
return
  {
    -- TODO: use a dynamic node for the ignore code. also, if none selected, dont insert []
    s({trig="ignore", name="Ignore type error", desc="Insert mypy ignore error"},
      fmta(
        [[
        # type: ignore [<>]
        ]],
        {
            i(1, "Ignore code"),
        }
      )
    )
  }
