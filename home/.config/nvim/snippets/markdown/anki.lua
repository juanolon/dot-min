local ls = require('luasnip')

return {
    s({trig="deck", name="Deck", desc="Add a new deck"},
    fmta(
        [[
            ---
            Deck: <>
            Tags: <>

            <>
            ---
        ]],
        {
        i(1, "deck"),
        i(2, "tags"),
        i(3)
        }
    ),
    {}
    ),
    s({trig="qa", name="question/answer", desc="Add a question and answer"},
    fmt(
        [[
        1. {}
            > {}
        ]],
        {
        i(1, "question?"),
        i(2, "answer")
        }
    ),
    {}
    ),
}
