let mapleader=","

syntax on

set termguicolors
set background=dark

colorscheme default

hi @variable guifg=#DDDDC5
hi Comment guifg=#666666
hi Conditional guifg=#8197BE
hi Constant guifg=#CF6A4C
hi Delimiter guifg=#DDDDC5
hi DiagnosticError guifg=#D35738
hi DiagnosticHint guifg=#c6b7ee
hi DiagnosticInfo guifg=#96b0de
hi DiagnosticWarn guifg=#FFB964
hi DiagnosticUnderlineError guisp=#D35738
hi DiagnosticUnderlineHint guisp=#c6b7ee
hi DiagnosticUnderlineInfo guisp=#96b0de
hi DiagnosticUnderlineWarn guisp=#FFB964
hi Directory guifg=#FFB964
hi ErrorMsg guifg=#605958
hi FloatBorder guifg=#99ad6b guibg=NONE
hi Function guifg=#FAD07A
hi Identifier guifg=#DDDDC5
hi Include guifg=#8FBFDC
hi IncSearch guibg=default guifg=#fce094 gui=inverse
hi Keyword guifg=#8197BE
hi Label guifg=#8197BF
hi LineNr guifg=#605958
hi Macro guifg=#8FBFDC
hi ModeMsg guifg=#FFFFFF guibg=#0087AF
hi Normal guibg=#151515 guifg=#E8E8D3
hi NormalFloat guibg=#151515
hi Number guifg=#CF6A4C
hi Operator guifg=#DDDDC5
hi PreProc guifg=#8FBFDC
hi Question guifg=#E6E6CD
hi Repeat guifg=#8197BF
hi Search guibg=default guifg=default gui=underdotted 
hi Special guifg=#799D6A
hi SpecialChar guifg=#C6B6EE
hi Statement guifg=#8197BE
hi StatusLine guifg=#9E9E9E guibg=transparent
hi StorageClass guifg=#C59F6F
hi String guifg=#99AD6A
hi Structure guifg=#8FBFDC
hi Type guifg=#FFB964
hi Visual guifg=default guibg=#303030
hi WinSeparator guifg=#333333
hi QuickFixLine guifg=DEFAULT guibg=#333333 gui=bold

" Markdown
hi markdownH1 guifg=#fad17a
hi markdownH2 guifg=#ffb372
hi markdownH3 guifg=#ffb372
hi markdownH4 guifg=#ffb372
hi markdownH5 guifg=#ffb372

hi markdownH1Delimiter guifg=#fad17a
hi markdownH2Delimiter guifg=#ffb372
hi markdownH3Delimiter guifg=#ffb372
hi markdownH4Delimiter guifg=#ffb372
hi markdownH5Delimiter guifg=#ffb372

hi markdownCode guifg=#8fbfdc
hi markdownCodeBlock guifg=#8fbfdc
hi markdownCodeDelimiter guifg=#4d636f

hi markdownAutomaticLink guifg=#cf6a4c
hi markdownUrlDelimiter guifg=#874937

hi VimwikiHeaderChar guifg=#fad17a
hi link VimwikiHeader1 markdownH1
hi link VimwikiHeader2 markdownH2
hi link VimwikiHeader3 markdownH3
hi link VimwikiHeader4 markdownH4
hi link VimwikiHeader5 markdownH5

" HTML
hi link htmlEndTag Function

" YAML
hi yamlBlockMappingKey guifg=#8197be
hi yamlBlockMappingDelimiter guifg=#4d636f
hi yamlPlainScalar guifg=#8fa364

filetype plugin indent on

set backspace=2
set clipboard=unnamed,unnamedplus
set encoding=utf-8
set expandtab
set hlsearch
set incsearch
set nobackup
set nomodeline
set noshowmode
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
set updatetime=100
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
nmap <leader>n :NERDTreeToggle<CR>
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

let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split = 4
let g:netrw_fastbrowse=0
let g:netrw_hide=1
let g:netrw_keepdir=0
let g:netrw_liststyle=3
let g:netrw_usetab=1
let g:netrw_winsize=-25
let g:netrw_special_syntax=1

hi netrwCompress  guifg=#5F5FAF
hi netrwData      guifg=#FF875F
hi netrwDoc	      guifg=#C5B5EC
hi netrwHdr	      guifg=#AFD787
hi netrwLex	      guifg=#787878
hi netrwLib	      guifg=#787878
hi netrwObj	      guifg=#787878
hi netrwPix	      guifg=#FFAF5F
hi netrwSymLink   guifg=#787878
hi netrwMakefile  guifg=#F9CF75
hi netrwTags	    guifg=#787878
hi netrwTilde	    guifg=#787878
hi netrwTmp	      guifg=#787878
hi netrwYacc	    guifg=#787878

set autochdir

" NERDTree
let NERDTreeDirArrowExpandable = '→'
let NERDTreeDirArrowCollapsible = '↓'
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', 'reports', '_workspace', '.zig-cache', 'zig-out', 'deps', 'vendor']

" GitGutter
let g:gitgutter_enabled = 1
let g:gitgutter_max_signs = 2500
let g:gitgutter_map_keys = 0

hi GitGutterAdd    guifg=#97a950 guibg=#2D3218 ctermfg=2
hi GitGutterChange guifg=#FFB964 guibg=#4c371e ctermfg=3
hi GitGutterDelete guifg=#d35738 guibg=#3f1a10 ctermfg=1
hi! link SignColumn LineNr " Clear unchanged lines background

" LeaderF
hi Lf_hl_popup_prompt guibg=#585858 guifg=#FFFFFF
hi Lf_hl_popup_cursor guibg=#FFB371
hi Lf_hl_popup_inputText guibg=#303030 guifg=#FFFFFF
hi Lf_hl_popup_inputMode guibg=#0087AF guifg=#FFFFFF
hi Lf_hl_popup_lineInfo guibg=#585858 guifg=#FFFFFF
hi Lf_hl_popup_total guibg=#D0D0D0 guifg=#6D6D6D
hi Lf_hl_cursorline guifg=#FFFFFF
hi Lf_hl_match guifg=#0087AF
hi Lf_hl_popup_normalMode guibg=#AFDF00 guifg=#005F00
hi Lf_hl_popup_category guibg=#005F87 guifg=#87DFFF
hi Lf_hl_popup_fullPathMode guibg=#0087AF guifg=#87DFFF
hi Lf_hl_popup_nameOnlyMode guibg=#303030 guifg=#9E9E9E
hi Lf_hl_popup_cwd guibg=#005F87 guifg=#87DFFF

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

" Vimwiki
let g:vimwiki_use_calendar = 1
let g:vimwiki_url_maxsave = 0
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path':'~/Documents/Wiki/', 'syntax':'markdown', 'ext':'.md', 'auto_tags':1, 'auto_diary_index':1, 'automatic_nested_syntaxes':1, 'nested_syntaxes':{'go': 'go'}}]
nmap <Leader>vn <Plug>VimwikiNextLink
nmap <Leader>vp <Plug>VimwikiPrevLink

" Ack
if executable('pt')
  let g:ackprg = 'pt --nocolor --nogroup --column'
endif
