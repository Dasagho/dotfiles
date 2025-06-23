return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

  -- 'cpea2506/one_monokai.nvim',

  -- "catppuccin/nvim",
  --  name = "catppuccin",
  --  lazy = false, -- los temas deben cargarse inmediatamente
  --  config = function()
  --    require("catppuccin").setup {
  --      flavour = "mocha", -- Opciones: latte, frappe, macchiato, mocha
  --      transparent_background = false, -- Si deseas un fondo transparente
  --      term_colors = true, -- Si deseas que los colores del terminal se integren
  --      styles = {
  --        comments = { "italic" },
  --      },
  --      integrations = {
  --        gitsigns = true,
  --        nvimtree = true,
  --        telescope = true,
  --        treesitter = true,
  --        cmp = true,
  --        fidget = true,
  --      },
  --    }
  --  end,

  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
}
