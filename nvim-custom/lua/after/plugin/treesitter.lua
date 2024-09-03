require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- Instala todos los parsers mantenidos
  highlight = {
    enable = true,              -- Resaltado de sintaxis basado en Treesitter
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,              -- Indentación basada en Treesitter
  },
}
