set nocompatible 			" Turns off strict vi compatibility	
filetype plugin indent on
set noerrorbells
set incsearch         " Search while typing
set background=dark 
syntax on

if has("gui_running")
  colorscheme ir_black	" Set the color scheme
  set cursorline    
else
  colorscheme rubyblue
endif

set nobackup				  " Do not write persistent backup
set writebackup				" Backup while editing
set ruler
set showcmd
set showmatch
set showmode
set cindent

" Searches the cwd and subdirectories with commands like :find, :grep, etc.
set path=.,**

" Ruby on Rails configuration
set numberwidth=5
" set nu
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ai
set expandtab
set smarttab
