" --- Colors ---

set background=dark

hi Directory    ctermfg=8
hi EndOfBuffer  ctermfg=0
hi LineNr       ctermfg=8 ctermbg=none
hi ModeMsg      ctermfg=7 ctermbg=4 
hi MoreMsg      ctermfg=2
hi Normal       ctermfg=none ctermbg=none
hi Pmenu        ctermfg=4 ctermbg=16     
hi PmenuSel     ctermfg=7 ctermbg=4
hi Question     ctermfg=3
hi SpecialKey   ctermfg=2
hi StatusLine   ctermfg=16 ctermbg=0
hi StatusLineNC ctermfg=16 ctermbg=0
hi TabLine      ctermfg=0 ctermbg=16 cterm=none
hi TabLineFill  ctermfg=16 ctermbg=16
hi TabLineSel   ctermfg=7 ctermbg=4
hi VertSplit    ctermfg=16 ctermbg=0
hi Visual       ctermfg=16 ctermbg=3 term=reverse
hi WarningMsg   ctermfg=3

" --- Core ---
set nocompatible
set number
set noruler
set nowrap
set laststatus=1
set mouse=a

" --- Indentation ---
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

" --- Search ---
set incsearch
set ignorecase
set smartcase

" --- Fast updates ---
set updatetime=100
set timeoutlen=300
set ttimeoutlen=50

" --- Keymaps ---

" toggle previous buffer (like <leader><leader>)
nnoremap ,, <C-^>

" yanking using xclip
vnoremap ,y :w !xclip -selection clipboard<CR><CR>
nnoremap ,yy :.w !xclip -selection clipboard<CR><CR>

" arrow-style splits (closer to your original)
nnoremap ,s<Left>  :leftabove vnew<CR>
nnoremap ,s<Right> :rightbelow vnew<CR>
nnoremap ,s<Up>    :leftabove new<CR>
nnoremap ,s<Down>  :rightbelow new<CR>

" command mode shortcut
nnoremap <Space> :

" window navigation
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" line navigation
nnoremap H ^
nnoremap L $
