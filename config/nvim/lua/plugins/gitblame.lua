return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy", -- Carga el plugin durante el inicio para optimizar el rendimiento
    opts = {
      enabled = false,  -- Desactiva el plugin por defecto
      message_template = " <summary> • <date> • <author>",
      date_format = "%m-%d-%Y",
      virtual_text_column = 1,
    },
    keys = {
      {
        "<leader>gb",
        "<cmd>GitBlameToggle<cr>",
        desc = "Alternar git blame",
      },
    },
  },
}
