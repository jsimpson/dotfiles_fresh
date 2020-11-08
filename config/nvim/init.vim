set nocp

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sheerun/vim-polyglot'

Plug 'gruvbox-community/gruvbox'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'thoughtbot/vim-rspec'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'

Plug 'itchyny/lightline.vim'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'vimwiki/vimwiki'

call plug#end()

syntax on
filetype plugin indent on

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set background=dark

" appearance
set cursorline
set hlsearch
set number
set relativenumber
set numberwidth=5
set ruler
set cmdheight=1

"" behavior
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

" coc.nvim
let g:coc_global_extensions = ['coc-solargraph', 'coc-deno', 'coc-clangd', 'coc-tsserver', 'coc-html', 'coc-css', 'coc-json']

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
      \ 'colorscheme': 'gruvbox',
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

augroup rainbow_parens
  au!
  au FileType c,h,cpp,hpp,python,javascript,typescript,javascriptreact,typescriptreact,ruby,eruby RainbowParentheses
augroup END

:lua << END
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true
    }
  }
END
