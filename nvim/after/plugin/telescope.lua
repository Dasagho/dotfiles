local builtin = require("telescope.builtin")
local telescope = require('telescope')

telescope.setup {
    defaults = {
	 file_ignore_patterns = {
	    "node_modules/",
	    ".git/",
	    "undo/",
	},
    },
    pickers = {
	find_files = {
	    hidden = true,
	}
    }
}

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-f>", builtin.grep_string, {})
vim.keymap.set("n", "<C-A-f>", builtin.live_grep, {})

