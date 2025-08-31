let mapleader=","

let g:explVertical=1
let g:explSplitRight=1
let g:explDetailedHelp=0
 
syntax on
filetype on

set noequalalways
set autoindent
set backspace=indent,eol,start
set bg=dark
set encoding=utf-8
set expandtab
set ffs=unix
set ff=unix
set history=1000
set incsearch
set laststatus=2
set nobackup
set nocompatible
set noerrorbells
set noswapfile
set nowrap
set nowritebackup
set ruler
set shiftwidth=4
set shortmess=lnrxI
set showbreak=+
set noshowcmd
set showmode
set smartindent
set tabstop=2
set ttyfast
set tw=64

colorscheme peachpuff

hi Comment         ctermfg=8
hi Conditional     ctermfg=4      
hi Constant        ctermfg=1
hi Delimiter       ctermfg=2 
hi ErrorMsg        ctermfg=9 ctermbg=16
hi Function        ctermfg=254
hi Identifier      ctermfg=254
hi Include         ctermfg=12
hi Label           ctermfg=4
hi LineNr          ctermfg=0
hi ModeMsg         ctermfg=7 ctermbg=4
hi NonText         ctermfg=16
hi Normal          ctermfg=252   
hi Number          ctermfg=1
hi PreProc         ctermfg=6
hi Repeat          ctermfg=4
hi SpecialChar     ctermfg=3
hi Special         ctermfg=70
hi Statement       ctermfg=252
hi StatusLine      ctermfg=7 ctermbg=0 cterm=bold
hi StorageClass    ctermfg=3
hi String          ctermfg=2
hi Structure       ctermfg=12
hi Type            ctermfg=254
hi VertSplit       ctermfg=16 ctermbg=0
hi Visual          term=reverse cterm=reverse

imap jj <ESC>

if bufwinnr(1)
    nmap ö <C-W><<C-W><
    nmap ä <C-W>><C-W>>
    nmap Ä <C-W>-<C-W>-
    nmap Ö <C-W>+<C-W>+
endif

nmap <leader>s<left> :leftabove vnew<CR>
nmap <leader>s<right> :rightbelow vnew<CR>
nmap <leader>s<up> :leftabove new<CR>
nmap <leader>s<down> :rightbelow new<CR>
nmap <leader>n :Explore<CR>

noremap <space> :
noremap <tab> <c-w>w
noremap <S-tab> <c-w>W
noremap H ^
noremap L $

nnoremap <leader><leader> <C-^>

map <leader>u :source ~/.vimrc
