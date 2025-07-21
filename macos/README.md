# .dotfiles

> [!Note]
> My config files (aka [dotfiles](http://en.wikipedia.org/wiki/Dotfiles)), they might be useful for someone else.

## Installation

```console
cd $HOME
git clone git@github.com:peterhellberg/dotfiles.git .dotfiles
ln -s .dotfiles/.??* -t .
unlink .git
```

## Neovim

The Vim configuration require [vim-plug](https://github.com/junegunn/vim-plug) to be installed.

```console
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### :CocConfig
```json
{
  "coc.preferences.useQuickfixForLocations": true,
  "extensions.updateCheck": "daily",
  "inlayHint.enable": false,
  "suggest.snippetIndicator": "",
  "snippets.priority": 200,
  "snippets.ultisnips.directories": [
    "UltiSnips",
    "gosnippets/UltiSnips"
  ],
  "zig.path": "/home/peter/Code/GitHub/zigtools/zls/zig-out/bin/zls",
  "zig.enabled": true,
  "zig.startUpMessage": false,
  "languageserver": {
    "tinymist": {
      "command": "/home/peter/.local/bin/tinymist-linux-x64",
      "filetypes": ["typst"]
    }
  },
  "clangd.path": "~/.config/coc/extensions/coc-clangd-data/install/18.1.3/clangd_18.1.3/bin/clangd",
  "snippets.ultisnips.pythonPrompt": false
}
```

## Software

- WezTerm from <https://github.com/wezterm/wezterm>
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

## Scripts in `~/.local/bin`

#### [clear-go](scripts/clear-go)
```sh
#!/bin/sh

clear && go $*
```

#### [clear-gotest](scripts/clear-gotest)
```sh
#!/bin/sh

clear && gotest $*
```

#### [clear-zig](scripts/clear-zig)
```sh
#!/bin/sh

clear && zig $*
```
