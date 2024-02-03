-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<ESC>", opts)
vim.keymap.set("n", "<leader>V", ":vsplit<CR>", opts)

-- Remove search highlight
vim.keymap.set("n", "<ESC>", ":noh<return><esc>", opts)

-- Split navigation
vim.keymap.set("n", "<C-j>", "<C-W>j", opts)
vim.keymap.set("n", "<C-k>", "<C-W>k", opts)
vim.keymap.set("n", "<C-h>", "<C-W>h", opts)
vim.keymap.set("n", "<C-l>", "<C-W>l", opts)

vim.keymap.set("t", "<C-j>", [[<C-\><C-N><C-w>j]], opts)
vim.keymap.set("t", "<C-k>", [[<C-\><C-N><C-w>k]], opts)
vim.keymap.set("t", "<C-h>", [[<C-\><C-N><C-w>h]], opts)
vim.keymap.set("t", "<C-l>", [[<C-\><C-N><C-w>l]], opts)

-- Mapeo de teclas para invocar el comando ToggleTerminal
vim.keymap.set("n", "`", ":ToggleTerminal<CR>", opts)
vim.keymap.set("t", "`", "<C-\\><C-n>:ToggleTerminal<CR>", opts)

-- Open terminal
vim.keymap.set("n", "<leader>tv", ":botright vnew <Bar> :terminal<CR>", opts)
vim.keymap.set("n", "<leader>th", ":botright new <Bar> :terminal<CR>", opts)

-- Undo Redo
vim.keymap.set("n", "<C-z>", ":undo<CR>", opts)
vim.keymap.set("n", "<C-A-z>", ":redo<CR>", opts)
vim.keymap.set("i", "<C-z>", "<ESC>:undo<CR>i", opts)
vim.keymap.set("i", "<C-A-z>", "<ESC>:redo<CR>i", opts)

-- Fold Open
vim.keymap.set("n", "<leader>-", ":foldclose<CR>", opts)
vim.keymap.set("n", "<leader>+", ":foldopen<CR>", opts)

-- Buffers navigation
vim.keymap.set("n", "<leader><Left>", ":tabPrev<CR>", opts)
vim.keymap.set("n", "<leader><Right>", ":tabNext<CR>", opts)
