local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

return
  {
    -- GENERIC ENVIRONMENT
    s({trig="begin"},
      fmta(
        [[
        \begin{<>}
            <>
        \end{<>}
      ]],
        {
          i(1),
          d(2, get_visual),
          rep(1),
        }
      ),
      {condition = line_begin}
    ),
    s({trig="eq"},
      fmta(
        [[
        \begin{equation}
            <>
        \end{equation}
      ]],
        {
          i(1),
        }
      ),
      { condition = line_begin }
    ),
    -- multiline EQUATION
    s({trig="multilineeq"},
      fmta(
        [[
        \begin{multiline}
            <>
        \end{multiline}
      ]],
        {
          d(1, get_visual),
        }
      ),
      { condition = line_begin }
    ),
    -- ALIGN
    s({trig="all"},
      fmta(
        [[
        \begin{align}
            <>
        \end{align}
      ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- ITEMIZE
    s({trig="item"},
      fmta(
        [[
        \begin{itemize}

            \item <>

        \end{itemize}
      ]],
        {
          i(0),
        }
      ),
      {}
    ),
    -- ENUMERATE
    s({trig="enum"},
      fmta(
        [[
        \begin{enumerate}

            \item <>

        \end{enumerate}
      ]],
        {
          i(0),
        }
      )
    ),
    -- INLINE MATH
    s({trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>$<>$",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),
    -- FIGURE
    s({trig = "fig"},
      fmta(
        [[
        \begin{figure}[htb!]
          \centering
          \includegraphics[width=<>\linewidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(4),
        }
      ),
      { condition = line_begin }
    ),
    -- URL 
    s({trig="url"},
      fmta(
        [[\url{<>}]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- href command with URL in visual selection
    s({trig="href"},
      fmta(
        [[\href{<>}{<>}]],
        {
          d(1, get_visual),
          i(2)
        }
      )
    ),
    s({trig="toc"},
      fmta(
        [[\tableofcontents]],
        { }
      )
    ),
    -- spaces: em, cm
    s({trig="hspace"},
      fmta(
        [[\hspace{<>}]],
        {
                    i(1)
                }
      )
    ),
  }
