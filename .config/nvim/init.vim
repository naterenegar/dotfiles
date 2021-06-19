syntax on

set guicursor=
set number
set relativenumber
set noerrorbells

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap

set noswapfile
set termguicolors

set cmdheight=2

set updatetime=50

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

colorscheme gruvbox
set background=dark

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()


lua require("lua_config")

" We want live_grep to work from the git base 
function! TelescopeGitLiveGrep() abort
  let gitroot = system('realpath --relative-to="." $(git rev-parse --show-toplevel)')[:-2]
  lua require('telescope.builtin').grep_string{search_dirs=vim.api.nvim_eval('[gitroot]')}
endfunction

nnoremap fd :call TelescopeGitLiveGrep()<CR>

