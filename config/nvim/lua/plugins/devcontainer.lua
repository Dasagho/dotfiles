return {
  'https://codeberg.org/esensar/nvim-dev-container',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  event = "User AlphaClosed",
  config = function()
    require("devcontainer").setup {}
  end
}
