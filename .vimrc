set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Plugin bundles
Bundle 'nanotech/jellybeans.vim'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-fugitive'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'rking/ag.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'terryma/vim-multiple-cursors'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle "garbas/vim-snipmate"

" Language bundles
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'slim-template/vim-slim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'sunaku/vim-ruby-minitest'
Bundle 'pangloss/vim-javascript'

filetype plugin indent on

let mapleader=","

color jellybeans

set cursorline
set expandtab
set modelines=0
set shiftwidth=2
set clipboard=unnamed
set synmaxcol=200
set ttyscroll=3
set encoding=utf-8
set tabstop=2
set nowrap
set number
set expandtab
set nowritebackup
set noswapfile
set nobackup
set nohlsearch
set incsearch
set ignorecase
set smartcase
set lazyredraw

set list listchars=tab:▸\ ,trail:·,extends:>,precedes:<
set completefunc=syntaxcomplete#Complete

" Automatic formatting
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufWritePre *.haml :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.scss :%s/\s\+$//e
autocmd BufWritePre *.slim :%s/\s\+$//e

au BufNewFile * set noeol

" No show command
autocmd VimEnter * set nosc

" Quick ESC
imap jj <ESC>

" Jump to the next row on long lines
map <Down> gj
map <Up>   gk
nnoremap j gj
nnoremap k gk

" format the entire file
nmap <leader>fef ggVG=

" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>

" Tab between buffers
noremap <tab> <c-w><c-w>

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" Resize buffers
if bufwinnr(1)
  nmap ö <C-W><<C-W><
  nmap ä <C-W>><C-W>>
  nmap Ä <C-W>-<C-W>-
  nmap Ö <C-W>+<C-W>+
endif

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_ruby_exec = '~/.rvm/rubies/ruby-2.0.0-p0/bin/ruby'

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" CtrlP
nnoremap <silent> t :CtrlP<cr>
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 600
let g:ctrlp_max_depth = 5

" Go programming
set rtp+=/usr/local/Cellar/go/1.0.3/misc/vim

au BufRead,BufNewFile *.go set filetype=go

autocmd BufWritePre *.go :%s/\s\+$//e
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Sass
au BufRead,BufNewFile *.scss set filetype=sass

" Quit with :Q
command -nargs=0 Quit :qa!

" Toggle tagbar
nmap § :TagbarToggle<CR>
