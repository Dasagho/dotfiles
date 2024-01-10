local lsp = require("lsp-zero")
lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>m", vim.diagnostic.goto_prev, opts)
end)

lsp.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		["gopls"] = {"golang"},
	}
})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		'tsserver',
		'eslint',
		'lua_ls',
		'gopls',
		'html',
		'cssls',
	},
	handlers = {
		lsp.default_setup,
	}
})
