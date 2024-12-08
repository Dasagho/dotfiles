return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  event = { "BufRead", "BufNewFile" },
  lazy = vim.fn.argc(-1) == 0,
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require "nvim-treesitter.query_predicates"
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "lua", "html", "javascript", "typescript", "css", "tsx", "json" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { "php" },
      },
      indent = {
        enable = true,
      },
      -- Removemos la configuración de autotag de aquí
      fold = {
        enable = true,
      },
    }

    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    vim.o.foldenable = false
    vim.o.foldlevel = 99
  end,
}