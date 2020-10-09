[ -z "$PS1" ] && return

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth
export HISTIGNORE="&:[ ]*:exit"
shopt -s histappend
export HISTFILE=~/.long_history
export HISTSIZE=9999
export HISTFILESIZE=9999

export AUTOFEATURE=true autotest

shopt -s checkwinsize

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable fzf
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

# enable colors for ls, etc...
if [ -f ~/.dircolors ]; then
    eval `dircolors -b ~/.dircolors`
else
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep -Hni --color=auto '
    alias egrep='egrep -Hni --color=auto '
fi

export EDITOR=/usr/bin/vim
export PS1="\[$(tput setaf 4)\]\u: \[$(tput setaf 5)\]\W \[$(tput sgr0)\]$ "

# easily go up lots of directories
function up {
    [ "${1/[^0-9]/}" == "$1" ] && {
        local ups=""
            for i in $(seq 1 $1); do
                ups=$ups"../"
            done
            cd $ups
        } || echo "usage: up INTEGER"
}

[ -z "$TMUX" ] && export TERM=st-256color

export FZF_DEFAULT_OPTS='
  --color fg:255,bg:236,hl:84,fg+:255,bg+:236,hl+:215
  --color info:141,prompt:84,spinner:212,pointer:212,marker:212
'

source ~/.aliases
source ~/.bash_completion

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    if [ -d "$HOME/.rbenv/shims" ]; then
        export PATH="$HOME/.rbenv/shims:$PATH"
    fi
    eval "$(rbenv init -)"
    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

if [ -d "$HOME/luarocks" ]; then
    export PATH="$HOME/luarocks/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export DENO_INSTALL="/home/jsimpson/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PATH="$HOME/opt/cross/bin:$PATH"
