local function find_phpcbf()
  local git_dir = vim.fs.find('.git', { upward = true, type = 'directory' })[1]
  if not git_dir then
    return nil -- fallback or error
  end
  local root = vim.fs.dirname(git_dir)
  return root .. '/smart_study_pro_api/phpcbf.sh'
end

return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre", "BufNewFile" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        -- Everything in opts will be passed to setup()
        opts = {
            log_level = vim.log.levels.DEBUG,
            -- log_level = vim.log.levels.TRACE,
            -- Define your formatters
            format_on_save = {
                timeout_ms = 3000, -- 3 seconds
            },
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format", "ruff_fix" },
                go = { "goimports", "gofmt" },
                -- python = { "isort", "black" },
                html = { "prettier" },
                javascript = { "prettier" },
                scss = { "prettier" },
                css = { "prettier" },
                php = { "phpcbf" }
            },
            -- Set up format-on-save
            format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
            -- Customize formatters
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
                prettier = {
                    require_cwd = true
                },
                -- phpcbf = {
                --     -- command = vim.fn.expand("~/.bin/phpcbf"),
                --     -- command = find_phpcbf,
                --     -- args = { "--standard=SlevomatCodingStandard", "$FILENAME" },
                --     -- args = { "$RELATIVE_FILEPATH" },
                --     args = { "--fix","$RELATIVE_FILEPATH" },
                --     --
                --     -- stdin = true,
                --     -- args = { "--stdin-path", "$FILENAME", "-" },
                --     --
                --     -- args = { "$FILENAME" },
                --     stdin = false,
                --     tmpfile_format = "conform.$RANDOM.$FILENAME",
                --     timeout = 10000,
                -- },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    }
}
