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
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
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
