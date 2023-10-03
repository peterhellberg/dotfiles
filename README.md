# .dotfiles

My config files (aka [dotfiles](http://en.wikipedia.org/wiki/Dotfiles)), they might be useful for someone else.

## Installation

```
cd $HOME
git clone git@github.com:peterhellberg/dotfiles.git .dotfiles
ln -s .dotfiles/.??* -t .
unlink .git
```
## Vim

The Vim configuration require [vim-plug](https://github.com/junegunn/vim-plug) to be installed.

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


### :CocConfig
```json
{
  "coc.preferences.useQuickfixForLocations": true,
  "coc.preferences.snippets.enable": true,
  "coc.preferences.extensionUpdateCheck": "never",
  "suggest.disableMenu": true,
  "suggest.snippetIndicator": "",
  "snippets.ultisnips.directories": [
    "UltiSnips",
    "gosnippets/UltiSnips"
  ],
  "languageserver": {
       "zls" : {
           "command": "/home/peter/Code/GitHub/zigtools/zls/zig-out/bin/zls",
           "filetypes": ["zig"]
       },
       "golang": {
           "command": "gopls",
           "filetypes": ["go"]
       }
   }
}
```

## Software

- iTerm2 from <https://iterm2.com/downloads.html>
- Firefox Developer Edition from <https://www.mozilla.org/en-US/firefox/developer/>
- Docker from <https://docs.docker.com/docker-for-mac>
- Homebrew from <https://brew.sh>
  - `brew install git vim go bash coreutils gnupg pinentry-mac pngcrush wget jq tig docker-compose`
- vim-plug from <https://github.com/junegunn/vim-plug>
- spy from <https://github.com/jpillora/spy>
- gotest from <https://github.com/rakyll/gotest>
- skitch from <https://gist.github.com/peterhellberg/e987022aa88aea216c26f8cd5f12b3dc>
- gocov from <https://github.com/axw/gocov>
- pt from <https://github.com/monochromegane/the_platinum_searcher>

## clear scripts in /opt/local/bin

#### `clear-go`
```sh
#!/bin/sh

clear && go $*
```

#### `clear-gotest`
```sh
#!/bin/sh

clear && gotest $*
```

#### `clear-go-run-imgcat`

```sh
#!/bin/sh

clear && go run . && imgcat $*
```
