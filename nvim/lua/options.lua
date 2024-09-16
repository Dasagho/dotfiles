vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.o.scrolloff = 12
vim.opt.wildignorecase = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.signcolumn = "yes:1"  -- Fija la columna de signos con un ancho de 2

-- Habilita el undo persistente
vim.o.undofile = true

-- Configura el directorio donde se guardarán los archivos de undo
vim.o.undodir = vim.fn.stdpath('data') .. '/undodir'

-- Establece un límite de tiempo de vida para los archivos de undo (en segundos)
-- 1 día = 86400 segundos
vim.cmd('set undoreload=10000') -- para evitar problemas con archivos grandes
vim.cmd('set undolevels=10000') -- niveles de undo

-- Crear un autocmd para limpiar los archivos de undo más antiguos que 1 día
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    local handle = io.popen('find ' .. vim.o.undodir .. ' -type f -mtime +1 -delete')
    handle:close()
  end,
})

-- Quitar el flag 'c' de 'formatoptions' para evitar que se continúe el comentario automáticamente
vim.api.nvim_command('autocmd FileType * setlocal formatoptions-=c')

-- Opcionalmente, también puedes desactivar otras opciones relacionadas:
vim.api.nvim_command('autocmd FileType * setlocal formatoptions-=r') -- Evita que continúe comentarios con el flag 'r'
vim.api.nvim_command('autocmd FileType * setlocal formatoptions-=o') -- Evita que se añada el comentario al usar 'o' o 'O'

