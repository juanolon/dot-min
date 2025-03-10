local map = require('utils').map
local opts = { noremap=true, silent=false }

-- format table: ! tr -s " " | column -t -s '|' -o '|'
map('v', '<leader>ft', ':!tr -s " " | column -t -s "|" -o "|"<CR>', opts)

-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
-- if require("zk.util").notebook_root(vim.fn.getcwd(0)) ~= nil then

    -- Open the link under the caret.
    -- map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

    -- Create a new note after asking for its title.
    -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
    map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
    -- Create a new note in the same directory as the current buffer, using the current selection for title.
    map("v", "<leader>zt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
    -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
    -- map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)

    -- Open notes linking to the current buffer.
    map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
    -- Alternative for backlinks using pure LSP and showing the source context.
    --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Open notes linked by the current buffer.
    map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

    -- Preview a linked note.
    map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- Open the code actions for a visual selection.
    map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)

    -- override default telescope file explorer
    -- map('n', '<C-t>', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
    map('n', '<C-t>', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)

    map("v", "<leader>zs", ":'<,'>ZkMatch<CR>", opts)

    map("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)


-- zk-nvim
-- Create a new note after asking for its title.
-- map("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: '), dir = vim.fn.expand('%:p:h') }<CR>")

-- Open notes.
-- map("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' }, dir = vim.fn.expand('%:p:h') }<CR>")
-- Open notes associated with the selected tags.

-- Search for the notes matching a given query.
-- map("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>")
-- Search for the notes matching the current visual selection.
-- map("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

-- map("v", "<leader>zi", ":'<,'>ZkNewFromTitleSelection {dir = vim.fn.expand('%:p:h')}<CR>")
end
