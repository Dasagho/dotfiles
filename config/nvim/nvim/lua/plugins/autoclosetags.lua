return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-ts-autotag").setup {
      -- Nueva estructura de configuración
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "xml",
          "php",
          "markdown",
          "astro",
          "glimmer",
          "handlebars",
          "hbs",
        },
      },
    }
  end,
}
