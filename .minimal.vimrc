let mapleader=","

syntax on

set termguicolors
set background=dark

colorscheme retrobox 

hi Comment guifg=#888888
hi Conditional guifg=#8197BE
hi Constant guifg=#CF6A4C
hi Delimiter guifg=#799D6A
hi Directory guifg=#DAD085
hi Function guifg=#FAD07A
hi Identifier guifg=#C6B6EE
hi Keyword guifg=#8197BE
hi LineNr guifg=#605958
hi Normal guibg=#151515 guifg=#E8E8D3
hi Number guifg=#CF6A4C
hi PreProc guifg=#8FBFDC
hi Special guifg=#799D6A
hi Statement guifg=#8197BE
hi StatusLine guifg=#303030 guibg=#9E9E9E
hi String guifg=#99AD6A
hi Structure guifg=#8FBFDC
hi Type guifg=#FFB964
hi ModeMsg guifg=#FFFFFF guibg=#0087AF
hi Visual guifg=default guibg=#303030
hi Search guibg=#EFEFEF guifg=#404040

filetype plugin indent on

set backspace=2
set clipboard=unnamed,unnamedplus
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
set shortmess=at
set shortmess+=I
set smartcase
set splitright
set tabstop=2
set timeoutlen=500
set ttimeoutlen=5
set virtualedit=block

autocmd VimEnter * set nosc

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
nmap <leader>n :Lexplore<CR>
nmap <leader>m :Lexplore %:p:h<CR>

noremap <space> :
noremap <tab> <c-w>w
noremap <S-tab> <c-w>W
noremap H ^
noremap L $

vnoremap u y
nnoremap U <C-r>
nnoremap J mzJ`z
nnoremap Y y$
nnoremap <leader><leader> <C-^>

let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[1 q"
let g:netrw_keepdir=0
let g:netrw_winsize=25
let g:netrw_banner=0
