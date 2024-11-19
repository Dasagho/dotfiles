return {
  "numToStr/Comment.nvim",
  opts = {
    -- add any options here
  },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("Comment").setup()
  end,
}
