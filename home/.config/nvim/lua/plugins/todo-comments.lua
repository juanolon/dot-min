return {
    {
        'folke/todo-comments.nvim',
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next TODO",
            },
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Previous TODO",
            },
        },
        opts = {
            signs = true,
            keywords = {
                TODO = { icon = "T", color = "todo" },
                INFO = { icon = "I", color = "info" },
                DONE = { icon = "D", color = "done" },
                CHECK = { icon = "C", color = "check" },
                TEST = { icon = "TT", color = "test" },
            },
            colors = {
                todo = { "#FF8C00" },
                info = { "#0C7C59" },
                done = { "#521d63" },
                check = { "#CA686B" },
                test = { "#c345e9" },
            },
            merge_keywords = true,
            highlight = {
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "fg", -- "fg" or "bg" or empty
                keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
            },
            pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        }
    }
}
