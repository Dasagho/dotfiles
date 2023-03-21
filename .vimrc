inoremap jk <Esc>

let mapleader = "´"

syntax on 		" Highlight syntax
set relativenumber	" Show line number
set noswapfile		" Disable the swap files
set hlsearch		" Highlight all results
set ignorecase		" Ignore case in search
set incsearch		" show search results as you type

if has('termguicolors')
   set termguicolors
endif

let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_better_performance = 1

set background=dark
packadd! gruvbox-material
colorscheme gruvbox-material 


