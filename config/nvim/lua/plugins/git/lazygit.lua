---@type LazyPluginSpec
return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  -- Comandos que activarán la carga del plugin
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- Configuración del plugin
  -- opts = {
  --   -- Configuración de la ventana flotante
  --   float_term_border = {
  --     "╭",
  --     "─",
  --     "╮",
  --     "│",
  --     "╯",
  --     "─",
  --     "╰",
  --     "│",
  --   },
  --   lazygit_floating_window_scaling_factor = 0.9, -- Escala de la ventana
  --   lazygit_floating_window_winblend = 0, -- Transparencia (0-100)
  --   lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }, -- Caracteres de las esquinas
  --   lazygit_use_custom_config_file_path = false, -- Usar archivo de configuración personalizado
  --   lazygit_config_file_path = "", -- Ruta al archivo de configuración personalizado
  -- },
  -- Atajos de teclado
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Abrir Lazygit' },
  },
  -- Configuración adicional
  config = function()
    -- Configurar variables de entorno
    vim.g.lazygit_floating_window_use_plenary = true
    vim.g.lazygit_use_neovim_remote = true

    -- Configurar colores personalizados para la ventana flotante
    vim.cmd [[
            highlight LazyGitBorder guifg=#3e4451
            highlight LazyGitFloat guibg=#282c34
        ]]
  end,
}
