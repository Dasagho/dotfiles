local builtin = require("telescope.builtin")
local telescope = require('telescope')

telescope.setup {
    pickers = {

	find_files = {

	    hidden = true
	}
    }
}

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
vim.keymap.set("n", "<C-r>", builtin.grep_string, {})
