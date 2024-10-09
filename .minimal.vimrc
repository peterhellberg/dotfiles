let mapleader=","

syntax on

set termguicolors
set background=dark

colorscheme sorbet 

filetype plugin indent on

set backspace=2
set clipboard=unnamed,unnamedplus
set cursorline
set encoding=utf-8
set expandtab
set hlsearch
set incsearch
set nobackup
set nomodeline
set noswapfile
set nowrap
set nowritebackup
set number
set shortmess+=I
set shortmess=at
set smartcase
set splitright
set tabstop=2
set timeoutlen=500
set ttimeoutlen=5
set virtualedit=block

" Vim annoyances
vnoremap u y
nnoremap U <C-r>
nnoremap J mzJ`z
nnoremap Y y$

au InsertEnter * set nocursorline
au InsertLeave * set cursorline nopaste

let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[1 q"

" No show command
autocmd VimEnter * set nosc

" Use space for :
noremap <space> :

" Quick ESC
imap jj <ESC>

" Open new buffers
nmap <leader>s<left> :leftabove vnew<CR>
nmap <leader>s<right> :rightbelow vnew<CR>
nmap <leader>s<up> :leftabove new<CR>
nmap <leader>s<down> :rightbelow new<CR>

" Tab between buffers
noremap <tab> <c-w>w
noremap <S-tab> <c-w>W

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" Go to home and end using capitalized directions
noremap H ^
noremap L $

" Resize buffers
if bufwinnr(1)
	nmap ö <C-W><<C-W><
	nmap ä <C-W>><C-W>>
	nmap Ä <C-W>-<C-W>-
	nmap Ö <C-W>+<C-W>+
endif

" Netrw config
nmap <leader>n :Lexplore<CR>
nmap <leader>m :Lexplore %:p:h<CR>
let g:netrw_keepdir=0
let g:netrw_winsize=25
let g:netrw_banner=0
