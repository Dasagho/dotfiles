local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Eliminar resaltado de búsqueda
map('n', '<ESC>', ':nohlsearch<CR>', opts)

-- No funciona usando mi config de tmux
vim.cmd('nnoremap <silent> <C-h> <C-w>h')
vim.cmd('nnoremap <silent> <C-j> <C-w>j')
vim.cmd('nnoremap <silent> <C-k> <C-w>k')
vim.cmd('nnoremap <silent> <C-l> <C-w>l')

map('n', '<leader>e', "<cmd>lua vim.diagnostic.open_float(nil, { focusable = false, scope = 'line', header = '🔍 LSP Diagnostics', border = 'rounded', source = 'always', prefix = '● ' })<CR>", { noremap = true, silent = true, desc = "show message inline" })


map('n', '<leader>z', "<cmd> lua vim.wo.wrap = not vim.wo.wrap<CR>", { noremap = true, silent = true, desc = "toggle wrap" })

map('n', '<leader>mm', "<cmd>lua require('bookmarks').add_bookmarks(true)<CR>", { noremap = true, silent = true, desc = "Add bookmark" })
map('n', '<leader>md', "<cmd>lua require('bookmarks').delete_on_virt()<CR>", { noremap = true, silent = true, desc = "Delete bookmark" })
map('n', '<leader>ml', "<cmd>lua require('bookmarks.list').show_desc()<CR>", { noremap = true, silent = true, desc = "Show bookmarks" })
-- map('n', '<leader>mm', "<cmd>lua require('bookmarks').add_bookmarks(true)<CR>", { noremap = true, silent = true, desc = "Add bookmark" })

map('i', 'jj', '<Esc>', opts)

map('n', '<leader>bp', ':bprevious<CR>', { noremap = true, silent = true, desc = "Prev buff" })
map('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true, desc = "Next buff" })

map('n', '<C-t>', 'tabnew', opts)
map('n', '<S-h>', ':tabprevious<CR>', { noremap = true, silent = true, desc = "Prev tab" })
map('n', '<S-l>', ':tabnext<CR>', { noremap = true, silent = true, desc = "Next tab" })

