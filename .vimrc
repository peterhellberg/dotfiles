call plug#begin('~/.vim/plugged')

" Go plugins
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig' 
Plug 'ray-x/go.nvim', { 'for': 'go' }

" Zig plugins
Plug 'ziglang/zig.vim'

" Plugin bundles
Plug 'vim-scripts/a.vim'
Plug 'honza/vim-snippets'
Plug 'peterhellberg/snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" Esoteric plugins
Plug 'Eric-Song-Nop/vim-glslx'

" Typesetting
Plug 'kaarmu/typst.vim'

" Markup plugins
Plug 'tpope/vim-markdown'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

" Git plugins
Plug 'airblade/vim-gitgutter', {'branch': 'main'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" Color scheme
Plug 'nanotech/jellybeans.vim'

" Add plugins to &runtimepath
call plug#end()

let g:lsc_auto_map = v:true

let mapleader=","

color jellybeans

set timeout
set timeoutlen=2000

if !has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=125
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

command! -nargs=1 Silent
      \   execute 'silent !' . <q-args>
      \ | execute 'redraw!'

set t_Co=256
set termguicolors

if $TERM_PROGRAM =~ "iTerm" || $TERM_PROGRAM =~ "WezTerm" || $TERM_PROGRAM =~ ""
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  autocmd VimEnter * set termguicolors
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

"let g:coc_start_at_startup=0

hi WinSeparator guifg=#202020
hi QuickFixLine guibg=#302028 guifg=#f0a0c0 cterm=underline
hi CocFloating guibg=#202020
hi CocMenuSel guibg=#303030
hi CocErrorHighlight guifg=#FE5753 guibg=#2E0302 gui=underline cterm=underline
hi CocErrorFloat guifg=#FE5753 gui=italic
hi CocErrorSign guifg=#FE5753 guibg=#2E0302

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
nnoremap <silent> ff :up<CR>
tnoremap <Esc> <C-\><C-n>

augroup neovim_terminal
    autocmd!
    autocmd TermOpen * startinsert
    autocmd TermOpen * :set nonumber norelativenumber
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END

" Disable cursor line in insert mode
au InsertEnter * set nocursorline
au InsertLeave * set cursorline nopaste

" Change the cursor in insert mode
if &term == 'xterm-256color' || &term == 'screen-256color'
  let &t_SI = "\<Esc>[5 q"
  let &t_EI = "\<Esc>[1 q"
endif

" Automatic formatting
function! <SID>StripTrailingSpace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Strip trailing space for a list of extensions
autocmd BufWritePre *.c,*.coffee,*.elm,*.ex,*.exs,*.typ,*.html,*.js,*.lua,*.markdown,*.md,*.rb,*.rs,*.scss,*.txt :call <SID>StripTrailingSpace()

" Set noeol on all new files
autocmd BufNewFile * set noeol

" No show command
autocmd VimEnter * set nosc

" Use space for :
noremap <space> :

" Quick ESC
imap jj <ESC>

" Save using ^s
nmap <c-s> :w<CR>

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

" Start search with å
nmap å /

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>

let NERDTreeDirArrowExpandable = '→'
let NERDTreeDirArrowCollapsible = '↓'
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', 'reports', '_workspace', 'zig-out', 'zig-cache', 'elf.disk', 'deps', 'vendor']

" Coc
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

nmap <leader>A  <Plug>(coc-codeaction)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)w
nmap <leader>f  <Plug>(coc-fix-current)
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

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

" GitGutter
let g:gitgutter_max_signs = 250
let g:gitgutter_map_keys = 0

hi GitGutterAdd    guifg=#97a950 guibg=#2D3218 ctermfg=2
hi GitGutterChange guifg=#FFB964 guibg=#4c371e ctermfg=3
hi GitGutterDelete guifg=#d35738 guibg=#3f1a10 ctermfg=1
hi! link SignColumn LineNr " Clear unchanged lines background

" Ack
set shellpipe=>

if executable('pt')
  let g:ackprg = 'pt --ignore=vendor --nocolor'
endif

" ASM ca65
au BufRead,BufNewFile *.s set filetype=asm_ca65

" PostgreSQL
let g:sql_type_default = 'pgsql'

" Navigation
" Map Ctrl+Arrows in mac OAOAOBOCODOAOBOB OA OAOB
map! <ESC>[OA <C-Up>
map! <ESC>[OB <C-Down>
map! <ESC>[OD <C-Left>
map! <ESC>[OC <C-Right>

" Vimwiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1, 'auto_diary_index': 1, 'automatic_nested_syntaxes': 1, 'nested_syntaxes': {'go': 'go'}}]
let g:vimwiki_use_calendar = 1
let g:vimwiki_url_maxsave = 0
let g:vimwiki_global_ext = 0
nmap <Leader>vn <Plug>VimwikiNextLink
nmap <Leader>vp <Plug>VimwikiPrevLink

function VimwikiStandup()
  VimwikiMakeDiaryNote
  w
  VimwikiDiaryIndex
  VimwikiDiaryGenerateLinks
  w
  VimwikiMakeDiaryNote
  if getline(1,'$') == ['']
    exec 'normal i'.system("standup.sh \| tr '\n' ' '")
  endif
endfunction

" Any filetype
autocmd FileType * nmap <leader>< <Plug>(coc-format)
autocmd FileType * nmap <leader>. <Plug>(coc-rename)
autocmd FileType * nmap gd <Plug>(coc-definition)

function! ToggleHover()
  if !CocAction('hasProvider', 'hover')
    return
  endif

  if coc#float#has_float()
    call coc#float#close_all()
  else
    call CocActionAsync('doHover')
  endif
endfunction
autocmd FileType * nmap <silent> § :call ToggleHover()<CR>

" Zig
autocmd FileType zig inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
autocmd FileType zig hi CocFloating ctermbg=Black 
autocmd FileType zig inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
autocmd FileType zig inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
autocmd FileType zig nmap <leader>rn <Plug>(coc-rename)
autocmd FileType zig nmap <leader>. <Plug>(coc-rename)
autocmd FileType zig nmap gd <Plug>(coc-definition)

let g:zig_fmt_autosave = 1

autocmd BufWritePre *.zig,*.zon call CocActionAsync('fixAll')
autocmd BufWritePre *.zig,*.zon call CocActionAsync('organizeImport')

" JS
autocmd FileType javascript hi CocFloating ctermbg=Black 
autocmd FileType javascript nmap <leader>. <Plug>(coc-rename)
autocmd FileType javascript nmap gd <Plug>(coc-definition)

" TS
autocmd FileType typescript hi CocFloating ctermbg=Black 
autocmd FileType typescript nmap <leader>. <Plug>(coc-rename)
autocmd FileType typescript nmap gd <Plug>(coc-definition)

" C
autocmd FileType c hi CocFloating ctermbg=Black 
autocmd FileType c nmap <leader>. <Plug>(coc-rename)
autocmd FileType c nmap gd <Plug>(coc-definition)

" autocmd BufWritePre *.c,*.h :normal gg=G``
"autocmd BufWritePre *.c,*.h :call CocAction('format')

" GLSLX
autocmd BufWritePre *.glslx :call CocAction('format')

" Go programming
au BufRead,BufNewFile *.go setl filetype=go nolist noexpandtab syntax=go

au FileType go nmap <Leader>d <Plug>(go-def-vertical)
au FileType go nmap <Leader>do <Plug>(go-doc-vertical)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <leader>c <Plug>(go-callers)
au FileType go nmap <leader>. <Plug>(coc-rename)

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mapping_enabled = 1
let g:go_disable_autoinstall = 1
let g:go_echo_go_info = 1
let g:go_echo_command_info = 0
let g:go_fmt_command = 'goimports'
let g:go_gorename_command = 'gopls'
let g:go_metalinter_command='golangci-lint'

augroup go
  autocmd!
  au FileType go command! -bang A GoAlt
  au FileType go command! -bang AV GoAltV
  au FileType go command! -bang AS GoAltS
augroup END

lua <<EOF
 require 'go'.setup({
   goimports = 'gopls', -- if set to 'gopls' will use golsp format
   gofmt = 'gopls', -- if set to gopls will use golsp format
   tag_transform = false,
   test_dir = '',
   lsp_cfg = true, -- false: use your own lspconfig
   lsp_on_attach = true, -- use on_attach from go.nvim
   lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
   lsp_codelens = false,
   dap_debug = false,
   lsp_inlay_hints = {
     style = 'eof',
     show_parameter_hints = false,
   },
})

-- Run gofmt + goimports on save

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

-- Alternate files
vim.api.nvim_create_user_command('A', function (args)
  vim.cmd('GoAlt' .. args)
end, { desc = "Alternate" })
EOF
