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

-- Open terminal
vim.keymap.set("n", "<leader>tv", ":botright vnew <Bar> :terminal<CR>", opts)
vim.keymap.set("n", "<leader>th", ":botright new <Bar> :terminal<CR>", opts)

-- Undo Redo
vim.keymap.set("n", "<C-z>", ":undo<CR>", opts)
vim.keymap.set("n", "<C-A-z>", ":redo<CR>", opts)

-- Fold Open
vim.keymap.set("n", "<leader>-", ":foldclose<CR>", opts)
vim.keymap.set("n", "<leader>+", ":foldopen<CR>", opts)
