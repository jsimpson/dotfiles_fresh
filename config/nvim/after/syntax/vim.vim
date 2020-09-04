unlet b:current_syntax
syn include @Lua syntax/lua.vim
syn region embedlua matchgroup=vimEmbedError start="^:lua << END$" end="^END$" keepend contains=@Lua
let b:current_syntax = 'vim'
