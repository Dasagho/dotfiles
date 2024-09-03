vim.g.mapleader = ' '

-- Ruta de instalación de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Verificar si lazy.nvim está instalado
if not vim.loop.fs_stat(lazypath) then
  -- Si no está instalado, clonarlo desde GitHub
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Usar la rama estable
    lazypath,
  })
end

-- Agregar lazy.nvim al runtime path de Neovim
vim.opt.rtp:prepend(lazypath)

-- Configurar lazy.nvim y cargar los plugins
require('lazy').setup('plugins')

-- Cargar el resto de la configuración

-- Cargar opciones
require('options')

-- Cargar mapeos de teclas
require('keymaps')

-- Configuración del LSP
require('lsp')

