filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Plugin dependencies
Plugin 'kana/vim-textobj-user'

" Plugin bundles
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'itchyny/lightline.vim'

" Go plugins
Plugin 'benmills/vim-golang-alternate'
Plugin 'fatih/vim-go'

" Ruby plugins
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'vim-ruby/vim-ruby'

" Rust plugins
Plugin 'racer-rust/vim-racer'
Plugin 'rust-lang/rust.vim'

" Esoteric plugins
Plugin 'kchmck/vim-coffee-script'
Plugin 'elixir-lang/vim-elixir'
Plugin 'elmcast/elm-vim'
Plugin 'fasterthanlime/ooc.vim'
Plugin 'maxbane/vim-asm_ca65'
Plugin 'rhysd/vim-crystal'
Plugin 'zah/nimrod.vim'

" Markup plugins
Plugin 'tpope/vim-markdown'
Plugin 'cespare/vim-toml'
Plugin 'cakebaker/scss-syntax.vim'

" Git plugins
Plugin 'tpope/vim-git'
Plugin 'airblade/vim-gitgutter'

" Color scheme
Plugin 'nanotech/jellybeans.vim'

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin indent on

let mapleader=","

color jellybeans

set hidden
set cursorline
set modelines=3
set shiftwidth=2
set clipboard=unnamed,unnamedplus
set mouse=c
set synmaxcol=256
set tabstop=2
set nowrap
set number
set expandtab
set nowritebackup
set noswapfile
set nobackup
set ignorecase
set smartcase
set lazyredraw
set showmatch
set splitright
set scrolloff=4
set sidescroll=1
set sidescrolloff=1
set noshowmode
set list listchars=tab:▸\ ,trail:·,extends:>,precedes:<
set omnifunc=syntaxcomplete#Complete

" Disable preview window
set completeopt-=preview

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

nnoremap <silent> <F5> :set paste!<CR>

set shortmess+=I
set virtualedit=block

" Disable cursor line in insert mode
au InsertEnter * set nocursorline
au InsertLeave * set cursorline nopaste

" Change the cursor in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

autocmd FileType * if &completefunc != '' | let &omnifunc=&completefunc | endif

" Automatic formatting
function! <SID>StripTrailingSpace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.rb,*.js,*.coffee,*.ex,*.exs,*.elm,*.rs :call <SID>StripTrailingSpace()
autocmd BufWritePre *.scss,*.haml,*.slim,*.html,*.builder :call <SID>StripTrailingSpace()
autocmd BufWritePre *.txt,*.md,*.markdown :call <SID>StripTrailingSpace()

au BufNewFile * set noeol

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

" Exit terminal
tnoremap <Leader>e <C-\><C-n>

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>

let NERDTreeMapOpenInTab='\t'
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', 'reports', 'Godeps', '_workspace', 'gin-bin', 'deps', '_build']

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"

" CtrlP
nnoremap <silent> t :CtrlP<cr>
nnoremap <silent><leader>t :CtrlP<cr>
nnoremap <silent><leader>r :CtrlPMRUFiles<cr>

let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 0
let g:ctrlp_max_files = 512
let g:ctrlp_max_depth = 6
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_user_command = {
  \ 'types': { 1: ['.git/', 'cd %s && git ls-files --cached --exclude-standard --others | grep -v _workspace | grep -v private_gems'] },
  \ 'fallback': 'ack -f %s --ignore-dir=.git | head -' . g:ctrlp_max_files
  \ }

" Ack
nmap <leader>a :Ack! 
set shellpipe=>

" Sass
au BufRead,BufNewFile *.scss set filetype=sass

" Slim
au BufRead,BufNewFile *.slim set filetype=slim

" ASM ca65
au BufRead,BufNewFile *.s set filetype=asm_ca65

" Go programming
au BufRead,BufNewFile *.go setl filetype=go nolist noexpandtab syntax=go
au BufEnter *.go setl nolist noexpandtab
autocmd BufWritePre *.go :%s/\s\+$//e
autocmd FileType go compiler go

au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <leader>c <Plug>(go-callers)
au FileType go nmap <Leader>do <Plug>(go-doc-vertical)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>d <Plug>(go-def-vertical)

let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_structs   = 1
let g:go_disable_autoinstall = 1
let g:go_fmt_command = "goimports"

" Elm
au FileType elm nnoremap <leader>el :ElmEvalLine<CR>
au FileType elm vnoremap <leader>es :<C-u>ElmEvalSelection<CR>
au FileType elm nnoremap <leader>em :ElmMakeCurrentFile<CR>
