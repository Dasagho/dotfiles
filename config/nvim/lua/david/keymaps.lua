-- ===============================
-- 🔁 Escape & Cancel behavior
-- ===============================
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear search highlights
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Change to normal mode' })

-- ===============================
-- 💬 Diagnostics
-- ===============================
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- ===============================
-- ⛔ Discourage arrow keys
-- ===============================
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- ===============================
-- 🪟 Window navigation (Alt)
-- ===============================
vim.keymap.set('n', '<A-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<A-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<A-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<A-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- ===============================
-- 🔄 Window movement (disabled, note only)
-- ===============================
-- NOTE: Some terminals have colliding keymaps or cannot send these keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- ===============================
-- 📑 Tab navigation (Shift)
-- ===============================
vim.keymap.set('n', '<S-h>', 'gT', { desc = 'Go to previous tab' })
vim.keymap.set('n', '<S-l>', 'gt', { desc = 'Go to next tab' })

-- ===============================
-- ✨ Highlight on yank
-- ===============================
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.keymap.set('n', '<leader>z', '<cmd> lua vim.wo.wrap = not vim.wo.wrap<CR>', { noremap = true, silent = true, desc = 'toggle wrap' })
