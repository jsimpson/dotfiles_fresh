set nocp

" appearance
set cursorline
set hlsearch
set number
set relativenumber
set numberwidth=5
set ruler
set cmdheight=2

"" behavior
"set autoread
"set autowrite
"set backspace=indent,eol,start
"set encoding=utf-8
"set incsearch
"set laststatus=2
"set lazyredraw
"set list
"set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
"set noerrorbells
"set nowrap
"set scrolloff=3
"set sidescrolloff=15
"set wrapscan
"
"" tab completion
"set path+=**
"set wildmode=list:longest,full
"set wildmenu
"set wildignore+=*/node_modules/*
"
"" indentation
"set autoindent
"set expandtab
"set softtabstop=2
"set shiftwidth=2
"set tabstop=2
"
"" mappings
"let mapleader=","
"
"cmap w!! w !sudo tee % > /dev/null
"map <leader>j :%!python -m json.tool<CR>
