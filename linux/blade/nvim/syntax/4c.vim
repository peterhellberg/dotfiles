" Syntax for 4C, the C-flavored language,
"  used in the 4B Fantasy Box.

if exists('b:current_syntax')
  finish
endif

" Identifiers are case-sensitive.
syn case match

syn keyword c4Type u4
syn keyword c4Keyword fn const for if else break continue
syn keyword c4Builtin cls flip peek halt buttons btn_left btn_right btn_up btn_down

" Function name after `fn`.
syn match c4Func '\<fn\>\s*\zs\w\+'

" Line comments.
syn match c4Comment '//.*$'

" Numbers: decimal, hex (0xA), binary (0b1010).
syn match c4Number '\<0[xX][0-9a-fA-F]\+\>'
syn match c4Number '\<0[bB][01]\+\>'
syn match c4Number '\<\d\+\>'

" Operators: single characters first; multi-character matches are declared
" later so they win when two matches start at the same column.
syn match c4Operator '[-+&=!<>]'
syn match c4Operator '+=\|-='
syn match c4Operator '<<\|>>'
syn match c4Operator '==\|!=\|<=\|>='
syn match c4Operator '&&\|||'
syn match c4Delimiter '[(){};,.]'

hi def link c4Type        Type
hi def link c4Keyword     Statement
hi def link c4Builtin     Function
hi def link c4Func        Function
hi def link c4Comment     Comment
hi def link c4Number      Number
hi def link c4Operator    Operator
hi def link c4Delimiter   Delimiter

let b:current_syntax = '4c'
