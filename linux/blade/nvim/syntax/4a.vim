" Syntax for 4A, the 4A Assembly language,
"  used in the 4B Fantasy Console.

if exists('b:current_syntax')
  finish
endif

" Identifiers are case-insensitive.
syn case ignore

syn keyword a4Mnemonic  nop lda sta read inc cls shl shr peek flip flag jmp ifeq ifgt iflt
syn keyword a4Directive const org dw
syn keyword a4Register  r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15

" Immediates: #10, #0xA, #0b1010, or a const name.
syn match a4Immediate '#[A-Za-z0-9_]\+'

" Bare numbers: flag slots, dw words, const values.
syn match a4Number '\<0[xX][0-9a-fA-F]\+\>'
syn match a4Number '\<0[bB][01]\+\>'
syn match a4Number '\<\d\+\>'

" @name: defines a label, a bare @name references one. The reference pattern
" must come first: when two matches start at the same column the one declared
" last wins, letting the definition claim @name: in full.
syn match a4LabelRef '@[A-Za-z_]\w*\%(\s*:\)\@!'
syn match a4LabelDef '@[A-Za-z_]\w*\ze\s*:'

syn match a4Comment ';.*$'

hi def link a4Mnemonic   Statement
hi def link a4Directive  PreProc
hi def link a4Register   Identifier
hi def link a4Immediate  Number
hi def link a4Number     Number
hi def link a4LabelDef   Define
hi def link a4LabelRef   Function
hi def link a4Comment    Comment

let b:current_syntax = '4a'
