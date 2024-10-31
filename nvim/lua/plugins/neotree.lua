return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  cmd = "Neotree", -- cargar solo cuando se invoque el comando
  config = function()
    vim.keymap.set("n", "<C-a>", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "File explorer" })
    vim.keymap.set(
      "n",
      "<leader>gs",
      "<cmd>Neotree git_status toggle<CR>",
      { noremap = true, silent = true, desc = "Git status" }
    )
    vim.keymap.set(
      "n",
      "<leader>be",
      "<cmd>Neotree buffers toggle<cr>",
      { noremap = true, silent = true, desc = "Buffer explorer" }
    )

    require("neo-tree").setup {
      filesystem = {
        change_cwd = false,
      },
    }
  end,
}
