return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-context',
                opts = {
                    -- Avoid the sticky context from growing a lot.
                    max_lines = 3,
                    -- Match the context lines to the source code.
                    multiline_threshold = 1,
                    -- Disable it when the window is too small.
                    min_window_height = 20,
                },
                keys = {
                    {
                        '[c',
                        function()
                            -- Jump to previous change when in diffview.
                            if vim.wo.diff then
                                return '[c'
                            else
                                vim.schedule(function()
                                    require('treesitter-context').go_to_context()
                                end)
                                return '<Ignore>'
                            end
                        end,
                        desc = 'Jump to upper context',
                        expr = true,
                    },
                },
            }
        },
        version = false,
        build = ':TSUpdate',
        opts = {
            highlight = {
                enable = true,
                -- disable = { 'latex', 'bibtex' },
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            indent = {
                enable = true,
                disable = {},
            },
            -- ignore_install = { "latex" },
            ensure_installed = {
                "tsx",
                "json",
                "yaml",
                "css",
                "html",
                "lua",
                "python",
                "markdown",
                "markdown_inline",
                "typescript",
                "vimdoc",
                "go",
                "bash",
                "vim",
                'gitcommit',
                "gitignore",
                "query",
                "dart",
                "javascript",
                "typescript",
                "latex",
                "comment",
                'regex',
                'yaml',
            },
            auto_install = false
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    }
}
