let mapleader=","

syntax on

set termguicolors
set background=dark

colorscheme default

hi Comment guifg=#888888
hi Conditional guifg=#8197BE
hi Constant guifg=#CF6A4C
hi Delimiter guifg=#799D6A
hi DiagnosticError guifg=#D35738
hi DiagnosticHint guifg=#8197BE
hi DiagnosticInfo guifg=#e8e8d3
hi DiagnosticWarn guifg=#FFB964
hi DiagnosticUnderlineError guisp=#D35738
hi DiagnosticUnderlineHint guisp=#8197BE
hi DiagnosticUnderlineInfo guisp=#e8e8d3
hi DiagnosticUnderlineWarn guisp=#FFB964
hi Directory guifg=#FFB964
hi ErrorMsg guifg=#605958
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
hi Question guifg=#E6E6CD
hi Repeat guifg=#8197BF
hi Search guibg=#EFEFEF guifg=#404040
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

" GitGutter
let g:gitgutter_enabled = 1
let g:gitgutter_max_signs = 250
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

lua vim.api.nvim_set_keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
lua vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
lua vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

" Vimwiki
let g:vimwiki_use_calendar = 1
let g:vimwiki_url_maxsave = 0
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path':'~/Documents/Wiki/', 'syntax':'markdown', 'ext':'.md', 'auto_tags':1, 'auto_diary_index':1, 'automatic_nested_syntaxes':1, 'nested_syntaxes':{'go': 'go'}}]
nmap <Leader>vn <Plug>VimwikiNextLink
nmap <Leader>vp <Plug>VimwikiPrevLink

" Ack
if executable('pt')
  let g:ackprg = 'pt --nocolor'
endif
