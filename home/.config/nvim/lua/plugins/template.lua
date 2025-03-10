return {
    {
        'glepnir/template.nvim',
        cmd = {'Template','TemProject'},
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>t",
                "<cmd>Telescope find_template type=insert<CR>",
                desc = "Use template",
            },
        },
        config = function()
            require('template').setup({
                temp_dir = '~/.config/nvim/templates',
                author = 'Juan Pablo Stumpf',
                email = 'juanpablo.stumpf@gmail.com'
            })
        end
    }
}
