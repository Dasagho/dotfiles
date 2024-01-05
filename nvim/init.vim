let mapleader = ","

" Commands custom
nnoremap <C-p> :lua require('telescope.builtin').find_files({cwd = vim.fn.getcwd()})<CR>
nnoremap <C-A-p> :Telescope find_files cwd=~<CR>
nnoremap <C-A-f> :Telescope live_grep cwd=%:p:h<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-b> :NvimTreeToggle<CR>
nnoremap <C-s> :lua require'nvim-tree.api'.tree.change_root_to_parent()<CR>

" Numbered line
set number
set relativenumber

" Syntax highlight
syntax enable

" Better search and case insensitive
set incsearch
set hlsearch

set ignorecase
set smartcase

" Share clipboard with host sistem
set clipboard=unnamedplus

" Persist Undos
set undofile
set undodir=~/.config/nvim/undo

" Auto indent
set autoindent
set smartindent

" Better UI
set showcmd
set wildmenu

" Conf tab
set tabstop=4
set shiftwidth=4
set expandtab

" Lines margin up and bottom
set scrolloff=10

" Avoid comment continue
set formatoptions-=cro

" Wrap text
set whichwrap+=b,s,h,l,<,>,[,],~

" autochange working directory
set autochdir

" Plugin Manager (vim-plug)
"
call plug#begin('~/.local/share/nvim/plugged')

Plug 'catppuccin/nvim', { 'as': 'frappe' }
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'lewis6991/gitsigns.nvim'
"Plug 'preservim/nerdtree'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'


call plug#end()

" Comment plugin config need
filetype plugin on

" treesitter configuration
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF

" Bottom bar configuration (vim-airline)
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = "\ue0b0"
let g:airline_left_alt_sep = "\ue0b0"
let g:airline_right_sep = "\ue0b2"
let g:airline_right_alt_sep = "\ue0b2"
" Dejar la configuración por defecto de airline para la sección a
let g:airline_section_b = '%{expand("%:t")}'
" Mostrar información de Git (requiere el plugin vim-fugitive)
let g:airline_section_x = airline#section#create(['%{airline#extensions#branch#get_head()}'])
let g:airline_section_y = '%y %m'
let g:airline_section_z = '%l:%v'

" gitsigns setup
lua << EOF
require('gitsigns').setup()
EOF

" nvim tree setup
" Desactivar netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Configurar termguicolors para habilitar grupos de resaltado
set termguicolors

" Configuración de nvim-tree usando Lua
lua << EOF
require("nvim-tree").setup()

-- O configurar con algunas opciones
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF

colorscheme catppuccin-frappe
