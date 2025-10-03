# .dotfiles

> [!Note]
> My config files (aka [dotfiles](http://en.wikipedia.org/wiki/Dotfiles)), they might be useful for someone else.

## Installation

```console
cd $HOME
git clone git@github.com:peterhellberg/dotfiles.git .dotfiles
# Symlink
```

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
