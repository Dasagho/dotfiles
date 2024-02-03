return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      },
      tailwindcss = {},
    },
  },
}
