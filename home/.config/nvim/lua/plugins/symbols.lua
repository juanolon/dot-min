return {
    {
        "oskarrrrrrr/symbols.nvim",
        keys = {
            {
                '<leader>o',
                '<cmd>SymbolsToggle<CR>',
                'Document symbols'
            }
        },
        config = function()
            local r = require("symbols.recipes")
            require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
                -- custom settings here
                -- e.g. hide_cursor = false
            })
        end
    }
}
