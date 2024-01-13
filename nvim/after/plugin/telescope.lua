local builtin = require("telescope.builtin")
local telescope = require('telescope')

telescope.setup {
    defaults = {
	 file_ignore_patterns = {
	    "node_modules/",
	    ".git/",
	},
    },
    pickers = {
	find_files = {
	    hidden = true,
	}
    }
}

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
vim.keymap.set("n", "<C-r>", builtin.grep_string, {})
