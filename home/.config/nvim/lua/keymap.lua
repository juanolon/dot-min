-- MAPS
local map = require('utils').map

map('c', 'w!!', '%!sudo tee > /dev/null %')
map('c', 'W', 'w')
map('c', 'Bd', 'Bd')

map('n', 'k', 'gk')
map('n', 'j', 'gj')
map('n', '0', 'g0')
map('n', '$', 'g$')

map('n', '<c-j>', '4j')
map('n', '<c-k>', '4k')
map('c', '<c-j>', '4j')
map('c', '<c-k>', '4k')

map('n', '<C-h>', '^')
map('n', '<C-l>', '$')
map('v', '<C-h>', '^')
map('v', '<C-l>', '$')

map('n', 'VV', 'V')
map('n', 'Vit', 'vitVkoj')
map('n', 'Vat', 'vatV ')
map('n', 'Vab', 'vabV ')
map('n', 'VaB', 'vaBV ')

map('c', '<C-b>', '<S-Left>')
map('c', '<C-w>', '<S-Right>')
map('c', '<C-j>', '<Down>')
map('c', '<C-k>', '<Up>')
map('c', '<C-h>', '<Left>')
map('c', '<C-l>', '<Right>')
map('c', '<C-d>', '<C-w>')

map('n', 'gp', '`[v`]')

map('n', '<C-n>', 'gt')
map('n', '<C-p>', 'gT')

map('n', '<C-w>O', '<C-w>T')

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<Down>", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>")
map("n", "<Up>", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>")
