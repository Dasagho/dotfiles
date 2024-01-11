vim.g.mapleader = " "

-- CharlieL settings
vim.opt.backup = false
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.signcolumn = 'yes'

-- change working directory
vim.opt.autochdir = false

-- Better search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.o.matchpairs = "(:),{:},[:],<:>"

-- Number left indicator
vim.opt.number = true
vim.opt.relativenumber = true

-- Share clipboard with host
vim.opt.clipboard = "unnamedplus"

-- Undo history
vim.opt.undofile = true

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Better UI (?)
vim.opt.showcmd = true
vim.opt.wildmenu = true

-- Avoid continue comment block
vim.o.formatoptions = "jqlt"

-- Wrap secctions
vim.o.whichwrap = "b,s,<,>,[,]"

-- Highlight groups
vim.o.termguicolors = true

-- View margin
vim.o.scrolloff = 10
