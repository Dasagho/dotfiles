return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  dependencies = {
    -- cmp sources
    { "hrsh7th/cmp-buffer", lazy = true },
    { "hrsh7th/cmp-path", lazy = true },
    { "hrsh7th/cmp-nvim-lsp", lazy = true },
    { "saadparwaiz1/cmp_luasnip", lazy = true },
    { "hrsh7th/cmp-nvim-lua", lazy = true },

    --list of default snippets
    { "rafamadriz/friendly-snippets", lazy = true },
    { "mlaursen/vim-react-snippets", lazy = true },

    -- autopairs , autocompletes ()[] etc
    {
      "windwp/nvim-autopairs",
      lazy = true,
      config = function()
        require("nvim-autopairs").setup {
          check_ts = true,
        }

        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        local cmp = require "cmp"
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },
  },
  -- made opts a function cuz cmp config calls cmp module
  -- and we lazyloaded cmp so we dont want that file to be read on startup!
  opts = function()
    require("vim-react-snippets").lazy_load()
    return require "plugins.configs.cmp"
  end,

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
}
