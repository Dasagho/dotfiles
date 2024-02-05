return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      },
      gopls = { "go" },
      tailwindcss = {},
    },
  },
}
