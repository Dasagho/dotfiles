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

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		'tsserver',
		'eslint',
		'lua_ls',
		'gopls',
		'intelephense',
		'html',
		'cssls',
	},
	handlers = {
		lsp.default_setup,
		intelephense = function()
			require('lspconfig').intelephense.setup({
				settings = {
       				 intelephense = {
       				     stubs = {
       				         "bcmath",
       				         "bz2",
       				         "Core",
       				         "curl",
       				         "date",
       				         "dom",
       				         "fileinfo",
       				         "filter",
       				         "gd",
       				         "gettext",
       				         "hash",
       				         "iconv",
       				         "imap",
       				         "intl",
       				         "json",
       				         "libxml",
       				         "mbstring",
       				         "mcrypt",
       				         "mysql",
       				         "mysqli",
       				         "password",
       				         "pcntl",
       				         "pcre",
       				         "PDO",
       				         "pdo_mysql",
       				         "Phar",
       				         "readline",
       				         "regex",
       				         "session",
       				         "SimpleXML",
       				         "sockets",
       				         "sodium",
       				         "standard",
       				         "superglobals",
       				         "tokenizer",
       				         "xml",
       				         "xdebug",
       				         "xmlreader",
       				         "xmlwriter",
       				         "yaml",
       				         "zip",
       				         "zlib",
       				         "wordpress-stubs",
       				         "woocommerce-stubs",
       				         "acf-pro-stubs",
       				         "wordpress-globals",
       				         "wp-cli-stubs",
       				         "genesis-stubs",
       				         "polylang-stubs"
       				     },
				     files = {
					     maxSize = 5000000
				     };
			     };
		     }
		})
	end,
	}
})
