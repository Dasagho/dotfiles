vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.o.scrolloff = 12
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmenu = false
vim.opt.signcolumn = "yes:1" -- Fija la columna de signos con un ancho de 2
vim.opt.cmdheight = 0
vim.opt.showtabline = 0

-- Habilita el undo persistente
vim.o.undofile = true

-- Configura el directorio donde se guardarán los archivos de undo
vim.o.undodir = vim.fn.stdpath "data" .. "/undodir"

-- Establece un límite de tiempo de vida para los archivos de undo (en segundos)
-- 1 día = 86400 segundos
vim.cmd "set undoreload=10000" -- para evitar problemas con archivos grandes
vim.cmd "set undolevels=10000" -- niveles de undo

-- Crear un autocmd para limpiar los archivos de undo más antiguos que 1 día
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local handle = io.popen("find " .. vim.o.undodir .. " -type f -mtime +1 -delete")
    handle:close()
  end,
})

-- Quitar el flag 'c' de 'formatoptions' para evitar que se continúe el comentario automáticamente
vim.api.nvim_command "autocmd FileType * setlocal formatoptions-=c"

-- Opcionalmente, también puedes desactivar otras opciones relacionadas:
vim.api.nvim_command "autocmd FileType * setlocal formatoptions-=r" -- Evita que continúe comentarios con el flag 'r'
vim.api.nvim_command "autocmd FileType * setlocal formatoptions-=o" -- Evita que se añada el comentario al usar 'o' o 'O'


-- Autocomando para limpiar todos los buffers al salir de Neovim
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- Cierra todos los buffers sin guardar (forzado)
    vim.cmd("%bd | e# | bd#")
  end,
  desc = "Cerrar todos los buffers excepto el actual al salir de Neovim",
})

vim.defer_fn(function()
  vim.lsp.codelens.refresh()
end, 5000)

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "docker-compose*.{yml,yaml}",
  command = "set filetype=yaml.docker-compose",
})
