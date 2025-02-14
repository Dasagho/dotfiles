return {
  "LintaoAmons/bookmarks.nvim",
  dependencies = {
    "kkharji/sqlite.lua",            -- Necesario para el almacenamiento persistente
    "nvim-telescope/telescope.nvim", -- Integración con Telescope para buscar bookmarks
    -- "stevearc/dressing.nvim",      -- Opcional, para mejorar la UI de los prompts
  },
  config = function()
    -- Configuración del plugin
    require("bookmarks").setup({
      -- Ruta del archivo de almacenamiento (puedes modificarla a tu gusto)
      save_file = vim.fn.expand("$HOME/.local/share/nvim/bookmarks.db"),
      -- Puedes consultar la documentación para ver todas las opciones disponibles
    })

    -- Mapeos de teclas para gestionar los bookmarks a nivel de línea:
    vim.keymap.set("n", "<leader>ml", "<cmd>BookmarksGoto<cr>", {
      noremap = true,
      silent = true,
      desc = "Abrir ventana de bookmarks",
    })
    vim.keymap.set("n", "<leader>mm", "<cmd>BookmarksMark<cr>", {
      noremap = true,
      silent = true,
      desc = "Marcar/desmarcar bookmark",
    })
    vim.keymap.set("n", "<leader>mk", "<cmd>BookmarksGotoPrev<cr>", {
      noremap = true,
      silent = true,
      desc = "Ir al bookmark anterior",
    })
    vim.keymap.set("n", "<leader>mj", "<cmd>BookmarksGotoNext<cr>", {
      noremap = true,
      silent = true,
      desc = "Ir al siguiente bookmark",
    })
  end,
}
