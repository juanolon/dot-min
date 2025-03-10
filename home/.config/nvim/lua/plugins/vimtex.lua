return {
    {
        "lervag/vimtex",
        lazy = false,
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            vim.g.vimtex_view_method = "zathura"

            vim.g.vimtex_compiler_latexmk = {
                build_dir = './build',
                options = {
                    '-pdf',
                    '-shell-escape',
                    '-verbose',
                    '-file-line-error',
                    '-synctex=1',
                    '-interaction=nonstopmode',
                }
            }
        end
    }
}
