call plug#begin('~/.vim/plugged')

" Go plugins
Plug 'fatih/vim-go'
Plug 'raphael/vim-present-simple'

" Plugin bundles
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'peterhellberg/snippets'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'nazo/pt.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'yssl/QFEnter'
Plug 'KorySchneider/vim-trim'
Plug 'godlygeek/tabular'

" Configuration file format plugins
Plug 'cespare/vim-toml'

" Esoteric plugins
Plug 'rust-lang/rust.vim'
Plug 'keith/swift.vim'
Plug 'elixir-editors/vim-elixir'

" Markup plugins
Plug 'tpope/vim-markdown'

" Git plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-git'

" Frontend plugins
Plug 'jparise/vim-graphql'

" Color scheme
Plug 'nanotech/jellybeans.vim'

" Add plugins to &runtimepath
call plug#end()

let mapleader=","

color jellybeans

set timeout
set timeoutlen=2000

if !has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

command! -nargs=1 Silent
      \   execute 'silent !' . <q-args>
      \ | execute 'redraw!'


set t_Co=256

if $TERM_PROGRAM =~ "iTerm"
  set termguicolors
endif

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set encoding=utf-8
set clipboard=unnamed,unnamedplus
set completeopt-=preview
set expandtab
set hidden
set ignorecase
set lazyredraw
set list listchars=tab:▸\ ,trail:·,extends:>,precedes:<
set modelines=3
set mouse=c
set nobackup
set nocursorcolumn
set nocursorline
set noshowmode
set noswapfile
set nowrap
set nowritebackup
set number
set omnifunc=syntaxcomplete#Complete
set re=1
set shiftwidth=2
set shortmess=at
set shortmess+=I
set showmatch
set sidescroll=1
set sidescrolloff=1
set smartcase
set splitright
set synmaxcol=1024
set tabstop=2
set virtualedit=block
set emoji
set updatetime=100

set t_BE=

hi QuickFixLine guibg=#302028 guifg=#f0a0c0 cterm=underline

syntax sync minlines=256

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Vim annoyances
" http://blog.sanctum.geek.nz/vim-annoyances/
vnoremap u y
nnoremap U <C-r>
nnoremap Q <nop>
nnoremap K <nop>
nnoremap J mzJ`z
nnoremap Y y$
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>

" Disable cursor line in insert mode
au InsertEnter * set nocursorline
au InsertLeave * set cursorline nopaste

" Change the cursor in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Automatic formatting
function! <SID>StripTrailingSpace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Strip trailing space for a list of extensions
autocmd BufWritePre *.builder,*.c,*.coffee,*.elm,*.ex,*.exs,*.haml,*.html,*.js,*.lua,*.markdown,*.md,*.rb,*.rs,*.scss,*.txt :call <SID>StripTrailingSpace()

" Set noeol on all new files
autocmd BufNewFile * set noeol

" No show command
autocmd VimEnter * set nosc

" Use space for :
noremap <space> :

" Quick ESC
imap jj <ESC>

" Jump to the next row on long lines
map <Down> gj
map <Up>   gk
nnoremap j gj
nnoremap k gk

" Open new buffers
nmap <leader>s<left>   :leftabove  vnew<cr>
nmap <leader>s<right>  :rightbelow vnew<cr>
nmap <leader>s<up>     :leftabove  new<cr>
nmap <leader>s<down>   :rightbelow new<cr>

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

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>

let NERDTreeDirArrowExpandable = '→'
let NERDTreeDirArrowCollapsible = '↓'
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', 'reports', 'Godeps', '_workspace', 'gin-bin', 'deps', '_build', 'vendor']

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"

" CtrlP
nnoremap <silent> t :CtrlP<cr>

let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 0
let g:ctrlp_max_files = 512
let g:ctrlp_max_depth = 8
let g:ctrlp_use_caching = 1
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_user_command = {
  \ 'types': { 1: ['.git/', 'cd %s && git ls-files --cached --exclude-standard --others | grep -v vendor'] },
  \ 'fallback': 'ack -f %s --ignore-dir=.git | head -' . g:ctrlp_max_files
  \ }

" GitGutter
let g:gitgutter_max_signs = 250
let g:gitgutter_map_keys = 0

" Ack
nmap <leader>a :Ack! 
set shellpipe=>

if executable('pt')
  let g:ackprg = 'pt --nocolor'
endif

" ASM ca65
au BufRead,BufNewFile *.s set filetype=asm_ca65

" Go programming
au BufRead,BufNewFile *.go setl filetype=go nolist noexpandtab syntax=go

au FileType go nmap <Leader>d <Plug>(go-def-vertical)
au FileType go nmap <Leader>do <Plug>(go-doc-vertical)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <leader>c <Plug>(go-callers)

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_disable_autoinstall = 1
let g:go_echo_go_info = 1
let g:go_fmt_command = 'goimports'
let g:go_gorename_command = 'gopls'
let g:go_metalinter_command='golangci-lint'

augroup go
  autocmd!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" Rust
let g:rustfmt_autosave = 1

" Navigation
" Map Ctrl+Arrows in mac OAOAOBOCODOAOBOB OA OAOB
map! <ESC>[OA <C-Up>
map! <ESC>[OB <C-Down>
map! <ESC>[OD <C-Left>
map! <ESC>[OC <C-Right>
