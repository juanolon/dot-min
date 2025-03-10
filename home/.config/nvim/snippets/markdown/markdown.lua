local ls = require("luasnip")
local u = require('utils')
local decorator = {
    condition = u.pipe({ u.in_text }),
}

local s = ls.extend_decorator.apply(ls.snippet, decorator)

return {
    s({trig="h1", name="Header 1", desc="Add header level 1"},
    fmta(
        [[
            # <>
        ]],
        {
        i(1, "title")
        }
    ),
    {}
    ),
    s({trig="h2", name="Header 2", desc="Add header level 2"},
    fmta(
        [[
          ## <>
        ]],
        {
        i(1, "title")
        }
    ),
    {}
    ),
    s({trig="h3", name="Header 3", desc="Add header level 3"},
    fmta(
        [[
          ### <>
        ]],
        {
        i(1, "title")
        }
    ),
    {}
    ),
    s({trig="h4", name="Header 4", desc="Add header level 4"},
    fmta(
        [[
          #### <>
        ]],
        {
        i(1, "title")
        }
    ),
    {}
    ),
    s({trig="h5", name="Header 5", desc="Add header level 5"},
    fmta(
        [[
          ##### <>
        ]],
        {
        i(1, "title")
        }
    ),
    {}
    ),
    s({trig="h6", name="Header 6", desc="Add header level 6"},
    fmta(
        [[
          ###### <>
        ]],
        {
        i(1, "title")
        }
    ),
    {}
    ),
    s({trig="codeblock", name="Codeblock", desc="Insert fenced code block"},
    fmta(
        [[
          ```<>
          <>
          ```
          <>
        ]],
        {
        i(1, "language"),
        i(2),
        i(3)
        }
    ),
    {}
    ),
    s({trig="---", name="Horizontal rule", desc="Insert horizontal rule"},
    fmta(
        [[
          ---
          <>
        ]],
        {
        i(1),
        }
    ),
    {}
    ),
    -- TODO add optional link name
    s({trig="link", name="Link", desc="Insert link"},
    fmta(
        [[
          [<>](<>)<>
        ]],
        {
        i(1, "text"),
        i(2, "url"),
        i(3),
        }
    ),
    {}
    ),
    s({trig="block", name="Blockquote", desc="Insert a blockquote"},
    fmt(
        [[
          > {}
          {}
        ]],
        {
        i(1, "bold text"),
        i(2)
        }
    ),
    {}
    ),
    s({trig="tt", name="Task",
        desc="Insert a task",
        snippetType="autosnippet"
    },
    fmt(
        [[
          - [ ] 
        ]],
        {
        }
    ),
    {}
    )
}
