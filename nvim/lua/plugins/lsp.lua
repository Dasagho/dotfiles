return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      },
      gopls = {
        filetypes = {
          "go",
          "gomod",
          "templ",
          "work",
        },
      },
      tailwindcss = {},
      jdtls = { "java" },
    },
  },
}
