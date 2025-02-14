local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Eliminar resaltado de búsqueda
map("n", "<ESC>", ":nohlsearch<CR>", opts)

-- ============================
-- === Moverse entre splits ===
-- ============================
map("n", "<M-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<M-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<M-k>", "<C-w>k", { noremap = true, silent = true })
map("n", "<M-l>", "<C-w>l", { noremap = true, silent = true })

-- ==================================
-- === Moverse entre buffers (opcional) ===
-- ==================================
map("n", "<M-,>", ":bprevious<CR>", { noremap = true, silent = true })
map("n", "<M-.>", ":bnext<CR>", { noremap = true, silent = true })

map(
  "n",
  "<leader>e",
  "<cmd>lua vim.diagnostic.open_float(nil, { focusable = false, scope = 'line', header = '🔍 LSP Diagnostics', border = 'rounded', source = 'always', prefix = '● ' })<CR>",
  { noremap = true, silent = true, desc = "show message inline" }
)

map(
  "n",
  "<leader>z",
  "<cmd> lua vim.wo.wrap = not vim.wo.wrap<CR>",
  { noremap = true, silent = true, desc = "toggle wrap" }
)

map("i", "jj", "<Esc>", opts)

map("n", "<leader>bp", ":bprevious<CR>", { noremap = true, silent = true, desc = "Prev buff" })
map("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buff" })
map("n", "<leader>bb", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "File explorer" })

map("n", "<C-t>", "tabnew", opts)
map("n", "<S-h>", ":tabprevious<CR>", { noremap = true, silent = true, desc = "Prev tab" })
map("n", "<S-l>", ":tabnext<CR>", { noremap = true, silent = true, desc = "Next tab" })
