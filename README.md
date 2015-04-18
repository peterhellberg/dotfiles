# .dotfiles

My config files (aka [dotfiles](http://en.wikipedia.org/wiki/Dotfiles)), they might be useful for someone else.

## Installation

```
cd $HOME
git clone git@github.com:peterhellberg/dotfiles.git .dotfiles
ln -s .dotfiles/.??* -t .
unlink .git
```
## .vimrc

The Vim configuration require [Vundle](https://github.com/gmarik/Vundle.vim) to be installed.

`git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
