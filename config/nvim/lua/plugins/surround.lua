return {
  "kylechui/nvim-surround",
  version = "*",
  event = "InsertEnter",
  config = function()
    require("nvim-surround").setup {
      keymaps = {
        insert = "<C-g>s",
        normal = "<leader>sy",
        delete = "<leader>sd",
        change = "<leader>sc",
        visual = "<leader>S",
      },
    }
  end,
}
