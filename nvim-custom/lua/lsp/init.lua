-- Cargar configuraciones de Mason
require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = { "pyright", "tsserver" }, -- Lista de servidores a instalar
    automatic_installation = true,
}

-- Configurar LSP con los servidores instalados por Mason
local lspconfig = require('lspconfig')
local servers = { "pyright", "tsserver" }  -- Añade aquí los servidores que estás usando

for _, server in ipairs(servers) do
    lspconfig[server].setup {}
end

-- Configuración de nvim-cmp
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- Utiliza 'vsnip' para snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
