local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Eliminar resaltado de búsqueda
map('n', '<ESC>', ':nohlsearch<CR>', opts)

-- No funciona usando mi config de tmux
vim.cmd('nnoremap <silent> <C-h> <C-w>h')
vim.cmd('nnoremap <silent> <C-j> <C-w>j')
vim.cmd('nnoremap <silent> <C-k> <C-w>k')
vim.cmd('nnoremap <silent> <C-l> <C-w>l')

-- Navegar entre diagnosticos de proyecto
map('n', '<leader>ce', ':Telescope diagnostics<CR>', opts)
