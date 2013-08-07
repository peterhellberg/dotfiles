" MacVim GUI mode
if has("gui_macvim")
  set guifont=Monaco:h13
  set guioptions=aAce
  set fuoptions=maxvert,maxhorz
  set noballooneval
  set noeb vb t_vb=

  " resize current buffer by +/- 5
  nnoremap <M-Right> :vertical resize +5<CR>
  nnoremap <M-Left> :vertical resize -5<CR>
  nnoremap <M-Up> :resize -5<CR>
  nnoremap <M-Down> :resize +5<CR>

  " Command+Option+Right for next
  map <D-M-Right> :tabn<CR>
  " Command+Option+Left for previous
  map <D-M-Left> :tabp<CR>

  " Automatically resize splits when resizing MacVim window
  autocmd VimResized * wincmd =
endif
