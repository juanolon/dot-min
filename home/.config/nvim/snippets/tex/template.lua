return
  {
    -- article
    s({trig="article"},
      fmta(
        [[
            \documentclass{article}

            \usepackage{array}
            \usepackage{float}
            \usepackage{graphicx}
            \usepackage{amsmath}

            \title{<>}
            \author{juan pablo stumpf}

            \begin{document}
            \maketitle
            <>
            \end{document}
      ]],
        {
          i(1),
          i(2),
        }
      ),
      {condition = line_begin}
    ),
}
