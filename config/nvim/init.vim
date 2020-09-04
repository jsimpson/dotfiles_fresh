set nocp

call plug#begin('~/.config/nvim/plugged')

Plug 'nanotech/jellybeans.vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-bundler'

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/rainbow_parentheses.vim'

call plug#end()

syntax on
filetype plugin indent on

set termguicolors
set background=dark
colorscheme jellybeans

" appearance
set cursorline
set hlsearch
set number
set relativenumber
set numberwidth=5
set ruler
set cmdheight=2

" behavior
set autoread
set autowrite
set backspace=indent,eol,start
set encoding=utf-8
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set noerrorbells
set nowrap
set scrolloff=3
set sidescrolloff=15
set wrapscan

" tab completion
set path+=**
set wildmode=list:longest,full
set wildmenu
set wildignore+=*/node_modules/*

" indentation
set autoindent
set expandtab
set softtabstop=2
set shiftwidth=2
set tabstop=2

" mappings
let mapleader=","

cmap w!! w !sudo tee % > /dev/null
map <leader>j :%!python -m json.tool<CR>

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <A-p> :Files<CR>

" au
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

augroup rainbow
  au!
  au FileType javascript,typescript,python,ruby RainbowParentheses
augroup END

" coc.nvim
let g:coc_global_extensions = ['coc-deno', 'coc-clangd', 'coc-tsserver', 'coc-html', 'coc-css', 'coc-json']

if isdirectory('./node_modules')
  if isdirectory('./node_modules/prettier')
    let g:coc_global_extensions += ['coc-prettier']
  endif
  if isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
  endif
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
     \ pumvisible() ? "\<C-n>" :
     \ <SID>check_back_space() ? "\<TAB>" :
     \ coc#refresh()

command! -nargs=0 DenoFmt :%!deno fmt .
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

"" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>r :CocRestart<CR>
nmap <silent> <leader>o :CocList outline<CR>
nmap <silent> <leader>s :CocList outline<CR>

" ag
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" lightline
let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'readonly', 'filename', 'modified', 'charhexvalue']
  \   ]
  \ },
  \ 'component': {
  \    'charhexvalue': '0x%B'
  \ }
  \ }

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" set popup menu bg color to match jellybeans theme better
hi Pmenu guibg=#1c1c1c
