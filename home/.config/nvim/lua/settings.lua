local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- Configs
-- opt.completeopt = "menuone,noselect"
-- cmd 'colorscheme gruvbox'
opt.termguicolors = true
opt.background = "dark"
opt.syntax = 'on'
opt.re = 0
-- cmd 'colorscheme melange'
-- cmd 'colorscheme PaperColor'
-- cmd 'colorscheme kanagawa' -- setup on plugin
g.python3_host_prog = '~/.pyenv/shims/python'

opt.mouse = 'a'
opt.clipboard = { 'unnamed' , 'unnamedplus' }

-- opt.completeopt = "menuone,noselect"
-- opt.completeopt = "menu,noinsert,noselect"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.hidden = true                   -- Enable background buffers
opt.joinspaces = false              -- No double spaces with join
-- g.mapleader = '\\'
g.mapleader = ' '
g.maplocalleader = ' '
--
-- UI {{{
opt.lazyredraw = true --do not redraw while running macros

opt.cmdheight = 2 -- set the commandheight
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.cursorline = true -- highlight current line
cmd 'hi CursorLine term=bold cterm=bold guibg=Grey40'
-- opt.wildignore+=*/.git/*,*/.hg/*,*/.svn/*
-- opt.wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg          " binary images
-- opt.wildignore+=*.DS_Store?                             " OSX bullshit
-- opt.wildignore+=*.pdf,*.dvi,*.ps                        " Documents

opt.ignorecase = true
opt.smartcase = true
opt.ruler = true -- show the cursor position all the time
opt.signcolumn = 'yes'

opt.scrolljump = 1 -- lines to scroll when cursor leaves screen
opt.scrolloff = 0 -- minimun lines to keep adove and below cursor
opt.showmatch = true
opt.showmode = true -- show the current mode

opt.relativenumber = true
opt.number = true

opt.showcmd = true -- show partial commands?
opt.magic = true --"magic for regular expressions

opt.list = true

opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
-- set listchars=tab:>\ ,eol:¬,extends:>,precedes:<
-- }}}

-- Tabs / Spaces {{{
opt.expandtab = true -- insert space character, when tab key is pressed
opt.tabstop = 4  --tabs and indenting
opt.shiftwidth = 4
opt.softtabstop = 4

opt.smartindent = true
opt.wrap = true
opt.linebreak = true
opt.shiftround = true -- always round indents to multiple of shiftwidth
opt.copyindent = true --"use existind indents for new indents
opt.preserveindent = true --"save as much indent structure as possible
-- }}}

-- fold {{{
-- opt.foldcolumn = '1' -- '0' is not bad
-- opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- opt.foldlevelstart = -1
-- opt.foldenable = true
-- }}}

-- SWAP/BACKUP {{{
opt.undodir = vim.fn.expand('~/.nvim/undo')
opt.backupdir = vim.fn.expand('~/.nvim/backup')
opt.directory = vim.fn.expand('~/.nvim/swap')
opt.undofile = true
opt.undolevels = 3000
opt.undoreload = 10000
opt.backup = true
opt.swapfile = false

opt.updatetime = 2000 -- wait for 2s until write to swap. also, to highlight word
-- }}}

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"

-- always show the tabline
vim.o.showtabline = 2

opt.fillchars = {
    stl = '─', -- statusline
    stlnc = '─', -- statusline
}

-- retab from 2 spaces to 4 (actually to tab, then tab to 4)
-- set ts=2 sts=2 noet | retab! | set ts=4 sts=4 et | retab!

