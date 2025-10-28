-- ===============================
-- 🗝️ Leader keys
-- ===============================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ===============================
-- 🧱 Tabs and indentation
-- ===============================
vim.opt.tabstop = 2 -- Number of spaces a <Tab> counts for
vim.opt.shiftwidth = 2 -- Indent width for >> and <<
vim.opt.expandtab = true -- Convert tabs to spaces

-- ===============================
-- 🔢 Line numbers
-- ===============================
vim.o.number = true -- Show absolute line numbers
vim.o.relativenumber = true -- Show relative line numbers

-- ===============================
-- 🖱️ Mouse
-- ===============================
vim.o.mouse = 'a' -- Enable mouse in all modes

-- ===============================
-- 🔤 Fonts and icons
-- ===============================
vim.g.have_nerd_font = true -- Enable Nerd Font support

-- ===============================
-- 🔍 Search behavior
-- ===============================
vim.o.ignorecase = true -- Ignore case in search
vim.o.smartcase = true -- Override ignorecase if uppercase is used

-- ===============================
-- 👁️ UI appearance
-- ===============================
vim.o.showmode = false -- Don’t show mode in command line
vim.o.signcolumn = 'yes' -- Always show the sign column
vim.o.cursorline = true -- Highlight the current line
vim.o.list = true -- Show invisible characters
vim.opt.listchars = { -- Set characters for tabs, trails, etc.
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

-- ===============================
-- 📋 Clipboard
-- ===============================
vim.opt.clipboard = 'unnamedplus'

-- ===============================
-- ✍️ Text behavior
-- ===============================
vim.o.breakindent = false -- Don’t preserve indentation on line wrap

-- Disable auto comment continuation
vim.api.nvim_command 'autocmd FileType * setlocal formatoptions-=c'
vim.api.nvim_command 'autocmd FileType * setlocal formatoptions-=r'
vim.api.nvim_command 'autocmd FileType * setlocal formatoptions-=o'

-- ===============================
-- 📁 Files and backup
-- ===============================
vim.o.undofile = true -- Save undo history to file
vim.opt.swapfile = false -- Don’t use swap files

-- ===============================
-- ⏱️ Timings and performance
-- ===============================
vim.o.updatetime = 250 -- Faster update time
vim.o.timeoutlen = 300 -- Time to wait for key sequences

-- ===============================
-- 🪟 Window splits
-- ===============================
vim.o.splitright = true -- Vertical splits open to the right
vim.o.splitbelow = true -- Horizontal splits open below

-- ===============================
-- 💬 Command line
-- ===============================
vim.opt.wildmenu = false -- Disable wildmenu
vim.o.inccommand = 'split' -- Live preview for :substitute

-- ===============================
-- 🔃 Scrolling
-- ===============================
vim.o.scrolloff = 12 -- Keep lines visible above/below cursor

-- ===============================
-- ✅ Confirm dialogs
-- ===============================
vim.o.confirm = true -- Prompt to save before quitting

-- ===============================
-- 🗂️ File types
-- ===============================
-- Set custom filetypes for specific filenames
vim.filetype.add {
  filename = {
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
  },
} -- Example: docker-compose files as yaml.docker-compose
