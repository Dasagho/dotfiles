local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<ESC>", opts)
vim.keymap.set("n", "<leader>V", ":vsplit<CR>", opts)

vim.keymap.set("n", "<ESC>", ":noh<return><esc>", opts)
