-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local terminal_buffer = nil
local terminal_window = nil

-- Grupo de AutoComandos para la terminal
local terminal_group = vim.api.nvim_create_augroup("TerminalToggle", { clear = true })

-- Función para alternar la visibilidad de la terminal
local function toggle_terminal()
  -- Verifica si el buffer de la terminal ya existe y está abierto
  if terminal_buffer and vim.api.nvim_buf_is_valid(terminal_buffer) then
    -- Intenta obtener la ventana que muestra el buffer de la terminal
    local win = vim.fn.bufwinid(terminal_buffer)
    if win ~= -1 then
      -- Si la ventana existe, oculta la ventana (cierra la ventana pero no mata el buffer)
      vim.api.nvim_win_close(win, true)
    else
      -- Si la ventana no existe, crea una nueva ventana split horizontalmente
      vim.cmd("botright split | wincmd J | buffer " .. terminal_buffer)
    end
  else
    -- Si el buffer de la terminal no existe, crea uno nuevo y abre la terminal
    vim.cmd("botright split | wincmd J | enew | setlocal nobuflisted | terminal")
    -- Guarda el ID del buffer de la terminal recién creado para uso futuro
    terminal_buffer = vim.api.nvim_get_current_buf()
  end
end
-- Registrar el comando para alternar la terminal
vim.api.nvim_create_user_command("ToggleTerminal", toggle_terminal, {})
