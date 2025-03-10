local api = vim.api
local util = vim.lsp.util
local log = vim.lsp.log
 
-- local location_callback = function(_, method, result)
--   if result == nil or vim.tbl_isempty(result) then
--   local _ = log.info() and log.info(method, 'No location found')
--   return nil
--   end
--
--   api.nvim_command('tab split')
--
--   if vim.tbl_islist(result) then
--     util.jump_to_location(result[1])
--     if #result > 1 then
--       util.set_qflist(util.locations_to_items(result))
--       api.nvim_command("copen")
--       api.nvim_command("wincmd p")
--     end
--   else
--     util.jump_to_location(result)
--   end
-- end
--
-- vim.lsp.handlers['textDocument/declaration']    = location_callback
-- vim.lsp.handlers['textDocument/definition']     = location_callback
-- vim.lsp.handlers['textDocument/typeDefinition'] = location_callback
-- vim.lsp.handlers['textDocument/implementation'] = location_callback


-- local hover_callback = function(_, method, result)
--   vim.lsp.util.focusable_float(method, function()
--     if not (result and result.contents) then
--       -- return { 'No information available' }
--       return
--     end
--     local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
--     markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
--     if vim.tbl_isempty(markdown_lines) then
--       -- return { 'No information available' }
--       return
--     end
--     local bufnr, winnr = vim.lsp.util.open_floating_preview(markdown_lines, "markdown", {
--       pad_left = 1; pad_right = 1;
--     })
--     vim.lsp.util.close_preview_autocmd({"CursorMoved", "BufHidden"}, winnr)
--     return bufnr, winnr
--   end)
-- end

-- vim.lsp.handlers['textDocument/hover'] = hover_callback
