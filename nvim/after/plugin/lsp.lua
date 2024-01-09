local lsp = require("lsp-zero")
lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>m", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		'tsserver',
		'eslint',
		'lua_ls',
		'gopls',
		'intelephense',
	},
	handlers = {
		lsp.default_setup,
	}
})
