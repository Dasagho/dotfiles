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
    vim.keymap.set("n", "<leader>bb", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "File explorer" })
    vim.keymap.set(
      "n",
      "<leader>gs",
      ":Neotree git_status toggle<CR>",
      { noremap = true, silent = true, desc = "Git status" }
    )

    require("neo-tree").setup {
      filesystem = {
        change_cwd = false,
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
    }
  end,
}
