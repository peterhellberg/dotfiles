let mapleader=","

syntax on

set termguicolors
set background=dark

colorscheme default

hi WinSeparator guifg=#333333
hi Comment guifg=#888888
hi Conditional guifg=#8197BE
hi Constant guifg=#CF6A4C
hi Delimiter guifg=#799D6A
hi Directory guifg=#DAD085
hi Function guifg=#FAD07A
hi Identifier guifg=#C6B6EE
hi Include guifg=#8FBFDC
hi Keyword guifg=#8197BE
hi Label guifg=#8197BF
hi LineNr guifg=#605958
hi Macro guifg=#8FBFDC
hi ModeMsg guifg=#FFFFFF guibg=#0087AF
hi Normal guibg=#151515 guifg=#E8E8D3
hi Number guifg=#CF6A4C
hi PreProc guifg=#8FBFDC
hi Repeat guifg=#8197BF
hi Search guibg=#EFEFEF guifg=#404040
hi Special guifg=#799D6A
hi SpecialChar guifg=#C6B6EE
hi Statement guifg=#8197BE
hi StatusLine guifg=#303030 guibg=#9E9E9E
hi StorageClass guifg=#C59F6F
hi String guifg=#99AD6A
hi Structure guifg=#8FBFDC
hi Type guifg=#FFB964
hi Visual guifg=default guibg=#303030

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
set shiftwidth=2
set shortmess=at
set shortmess+=I
set smartcase
set splitright
set tabstop=2
set timeoutlen=500
set ttimeoutlen=5
set virtualedit=block
set mouse=

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
nnoremap <silent> ff :up<CR>

let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[1 q"
let g:netrw_keepdir=0
let g:netrw_winsize=25
let g:netrw_banner=0
let g:netrw_browse_split = 4
let g:netrw_altv=1

set autochdir

augroup go
  autocmd BufRead *.go setlocal noexpandtab
  autocmd BufWritePre *.go lua vim.lsp.buf.format({ async = false })
augroup END


" LeaderF
let g:Lf_WindowPosition = 'popup'
let g:Lf_ShortcutF = "<silent> t"
let g:Lf_HideHelp = 1
let g:Lf_ShowDevIcons = 0
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
let g:Lf_WorkingDirectoryMode = 'a'
let g:Lf_UseMemoryCache = 0
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PopupColorscheme = 'gruvbox_default'
let g:Lf_WildIgnore = {
        \ 'dir': ['.git', 'zig-cache'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so', '*.wasm']
        \}
