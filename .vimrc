set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Plugin dependencies
Plugin 'kana/vim-textobj-user'

" Plugin bundles
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'
Plugin 'honza/vim-snippets'
Plugin 'peterhellberg/snippets'
Plugin 'itchyny/lightline.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'

" Go plugins
Plugin 'fatih/vim-go'
Plugin 'raphael/vim-present-simple'

" Ruby plugins
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'vim-ruby/vim-ruby'

" Esoteric plugins
Plugin 'rust-lang/rust.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'elmcast/elm-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'maxbane/vim-asm_ca65'
Plugin 'rhysd/vim-crystal'
Plugin 'zah/nimrod.vim'
Plugin 'dleonard0/pony-vim-syntax'
Plugin 'lluchs/vim-wren'

" Markup plugins
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'tpope/vim-markdown'

" Git plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-git'

" Color scheme
Plugin 'nanotech/jellybeans.vim'

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin indent on

let mapleader=","

color jellybeans

set termguicolors
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

autocmd FileType * if &completefunc != '' | let &omnifunc=&completefunc | endif

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

let NERDTreeMapOpenInTab='\t'
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', 'reports', 'Godeps', '_workspace', 'gin-bin', 'deps', '_build', 'vendor']

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
let g:ctrlp_max_files = 256
let g:ctrlp_max_depth = 4
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_user_command = {
  \ 'types': { 1: ['.git/', 'cd %s && git ls-files --cached --exclude-standard --others | grep -v vendor | grep -v _workspace | grep -v private_gems'] },
  \ 'fallback': 'ack -f %s --ignore-dir=.git | head -' . g:ctrlp_max_files
  \ }

" GitGutter
let g:gitgutter_max_signs = 2500

" Ack
nmap <leader>a :Ack! 
set shellpipe=>

" ASM ca65
au BufRead,BufNewFile *.s set filetype=asm_ca65

" Go programming
au BufRead,BufNewFile *.go setl filetype=go nolist noexpandtab syntax=go

au FileType go nmap <Leader>d <Plug>(go-def-vertical)
au FileType go nmap <Leader>do <Plug>(go-doc-vertical)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <leader>c <Plug>(go-callers)

let g:go_disable_autoinstall = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs   = 1
let g:go_fmt_command = "goimports"

augroup go
  autocmd!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" Rust
let g:rustfmt_autosave = 1
