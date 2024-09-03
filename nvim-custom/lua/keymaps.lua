local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Eliminar resaltado de búsqueda
map('n', '<ESC>', ':nohlsearch<CR>', opts)

-- No funciona usando mi config de tmux
vim.cmd('nnoremap <silent> <C-h> <C-w>h')
vim.cmd('nnoremap <silent> <C-j> <C-w>j')
vim.cmd('nnoremap <silent> <C-k> <C-w>k')
vim.cmd('nnoremap <silent> <C-l> <C-w>l')

-- Telescope
map('n', '<Leader><Space>', ':Telescope find_files<CR>', opts)

-- Nvim-tree
map('n', '<Leader>b', ':NvimTreeToggle<CR>', opts)

-- Lanzar o continuar el debugger
map('n', '<leader>dd', '<cmd>lua require"dapui".toggle()<CR>', opts)
-- Alternar punto de parada en la línea actual
map('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
-- Ver variables o evaluar expresiones
map('n', '<leader>de', '<cmd>lua require"dap.ui.widgets".hover()<CR>', opts)
-- Detener la sesión de depuración
map('n', '<leader>dq', '<cmd>lua require"dap".terminate()<CR>', opts)
-- Avanzar al siguiente paso (step over)
map('n', '<leader>ds', '<cmd>lua require"dap".step_over()<CR>', opts)
-- Entrar en la función (step into)
map('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>', opts)
-- Salir de la función (step out)
map('n', '<leader>do', '<cmd>lua require"dap".step_out()<CR>', opts)

