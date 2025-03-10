local lsp = vim.lsp
local handlers = lsp.handlers
local methods = vim.lsp.protocol.Methods
local rename = require('rename').rename

-- local pop_opts = { border = "rounded", max_width = 80 }
-- handlers["textDocument/hover"] = lsp.with(handlers.hover, pop_opts)
-- handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, pop_opts)

vim.diagnostic.config({
    -- virtual_text = {
    --   prefix = '⠿', -- Could be '●', '▎', 'x'
    -- },
    virtual_text = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

-- icons
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


local on_attach = function(client, bufnr)
    if client.name == 'ruff' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = bufnr }
    if client.supports_method(methods.textDocument_signatureHelp) then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>rn', rename, opts)
    vim.keymap.set('n', '<leader>ca', '<cmd>lua require("fastaction").code_action()<CR>', opts)
    vim.keymap.set('v', '<leader>ca', '<cmd>lua require("fastaction").range_code_action()<CR>', opts)

    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

    if client.supports_method(methods.textDocument_definition) then
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<CR>", opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<CR>", opts)
    end


    -- if client.supports_method(methods.textDocument_formatting) then
    --     -- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
    --     vim.keymap.set('n', '<leader>f', function ()
    --         vim.lsp.buf.format({async=true})
    --     end, opts)
    -- end

    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, wrap = true }) end,
        opts)
    vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true }) end,
        opts)

    -- Set autocommands conditional on server_capabilities
    -- if client.server_capabilities.document_highlight then
    --     vim.api.nvim_exec([[
    --     augroup lsp_document_highlight
    --     autocmd! * <buffer>
    --     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --     augroup END
    --     ]], false)
    -- end

    if client.supports_method(methods.textDocument_documentHighlight) then
        local under_cursor_highlights_group =
            vim.api.nvim_create_augroup('dotfile/cursor_highlights', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Clear highlight references',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    -- if client.supports_method(methods.textDocument_signatureHelp) then
    --     vim.keymap.set('n', '<leader>k', function()
    --         -- Close the completion menu first (if open).
    --         local cmp = require 'cmp'
    --         if cmp.visible() then
    --             cmp.close()
    --         end
    --
    --         vim.lsp.buf.signature_help()
    --     end)
    -- end

    -- lsp signature
    -- require "lsp_signature".on_attach({
    --     bind = true,
    --     fix_pos = true,
    --     handler_opts = {
    --         border = "single"
    --     }
    -- })
end

local md_namespace = vim.api.nvim_create_namespace 'dotfile/lsp_float'

--- Adds extra inline highlights to the given buffer.
---@param buf integer
local function add_inline_highlights(buf)
    for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        for pattern, hl_group in pairs {
            ['@%S+'] = '@parameter',
            ['^%s*(Parameters:)'] = '@text.title',
            ['^%s*(Return:)'] = '@text.title',
            ['^%s*(See also:)'] = '@text.title',
            ['{%S-}'] = '@parameter',
            ['|%S-|'] = '@text.reference',
        } do
            local from = 1 ---@type integer?
            while from do
                local to
                from, to = line:find(pattern, from)
                if from then
                    vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
                        end_col = to,
                        hl_group = hl_group,
                    })
                end
                from = to and to + 1 or nil
            end
        end
    end
end

--- LSP handler that adds extra inline highlights, keymaps, and window options.
--- Code inspired from `noice`.
---@param handler fun(err: any, result: any, ctx: any, config: any): integer?, integer?
---@param focusable boolean
---@return fun(err: any, result: any, ctx: any, config: any)
-- local function enhanced_float_handler(handler, focusable)
--     return function(err, result, ctx, config)
--         local bufnr, winnr = handler(
--             err,
--             result,
--             ctx,
--             vim.tbl_deep_extend('force', config or {}, {
--                 border = 'rounded',
--                 focusable = focusable,
--                 max_height = math.floor(vim.o.lines * 0.5),
--                 max_width = math.floor(vim.o.columns * 0.4),
--             })
--         )
--
--         if not bufnr or not winnr then
--             return
--         end
--
--         -- Conceal everything.
--         vim.wo[winnr].concealcursor = 'n'
--
--         -- Extra highlights.
--         add_inline_highlights(bufnr)
--
--         -- Add keymaps for opening links.
--         if focusable and not vim.b[bufnr].markdown_keys then
--             vim.keymap.set('n', '<leader>K', function()
--                 -- Vim help links.
--                 local url = (vim.fn.expand '<cWORD>' --[[@as string]]):match '|(%S-)|'
--                 if url then
--                     return vim.cmd.help(url)
--                 end
--
--                 -- Markdown links.
--                 local col = vim.api.nvim_win_get_cursor(0)[2] + 1
--                 local from, to
--                 from, to, url = vim.api.nvim_get_current_line():find '%[.-%]%((%S-)%)'
--                 if from and col >= from and col <= to then
--                     vim.system({ 'xdg-open', url }, nil, function(res)
--                         if res.code ~= 0 then
--                             vim.notify('Failed to open URL' .. url, vim.log.levels.ERROR)
--                         end
--                     end)
--                 end
--             end, { buffer = bufnr, silent = true })
--             vim.b[bufnr].markdown_keys = true
--         end
--     end
-- end
-- vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover, true)
-- vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help, false)

--- HACK: Override `vim.lsp.util.stylize_markdown` to use Treesitter.
---@param bufnr integer
---@param contents string[]
---@param opts table
---@return string[]
---@diagnostic disable-next-line: duplicate-set-field
-- vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
--     contents = vim.lsp.util._normalize_markdown(contents, {
--         width = vim.lsp.util._make_floating_popup_size(contents, opts),
--     })
--     vim.bo[bufnr].filetype = 'markdown'
--     vim.treesitter.start(bufnr)
--     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
--
--     add_inline_highlights(bufnr)
--
--     return contents
-- end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
        return
    end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- I don't think this can happen but it's a wild world out there.
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})
