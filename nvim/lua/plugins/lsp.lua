return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      intelephense = {
        settings = {
          intelephense = {
            stubs = {
              "wordpress",
              "wordpress-globals",
            },
          },
        },
      },
    },
  },
}
