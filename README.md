# dotfiles

a constant work in progress. art by any other name.

# symlinks

```bash
ln -s ~/dotfiles/bashrc ~/.bashrc
ln -s ~/dotfiles/bash_completion ~/.bash_completion
ln -s ~/dotfiles/bash_completion.d ~/.bash_completion.d
ln -s ~/dotfiles/aliases ~/.aliases
ln -s ~/dotfiles/dircolors ~/.dircolors
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

ln -s ~/dotfiles/config/nvim ~/.config/nvim
ln -s ~/dotfiles/bin ~/bin
```

# misc

## profiling vim

```vimscript
:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
:profile pause
:noautocmd qall!
```
