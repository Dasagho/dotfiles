return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- los temas deben cargarse inmediatamente
  priority = 1000,
  config = function()
    require("catppuccin").setup {
      flavour = "mocha", -- Opciones: latte, frappe, macchiato, mocha
      transparent_background = false, -- Si deseas un fondo transparente
      term_colors = true, -- Si deseas que los colores del terminal se integren
      styles = {
        comments = { "italic" },
      },
      integrations = {
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        cmp = true,
        fidget = true,
      },
    }
  end,
}
