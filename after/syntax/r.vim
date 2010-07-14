" With some lines of code borrowed from Zhuojun Chen.

" New line, carriage return, tab, bell, feed, backslash
syn match rSpecial display contained "\\\(n\|r\|t\|a\|f\|'\|\"\)\|\\\\"

" Hexadecimal and Octal digits
syn match rSpecial display contained "\\\(x\x\{1,2}\|\o\{1,3}\)"

syn keyword rBoolean  T F
syn keyword rConstant R.version.string
syn match rComment contains=@Spell /\#.*/
syn region rString contains=rSpecial,@Spell start=/"/ skip=/\\\\\|\\"/ end=/"/
syn region rString contains=rSpecial,@Spell start=/'/ skip=/\\\\\|\\'/ end=/'/
syn match   rOperator    /[\*\!\%\&\+\-\<\>\=\^\|\~\`/:@]/
syn match   rOperator    /%o%\|%x%\|xor\|isTRUE\|%in%/
syn match rDollar /\$/
syn keyword rBoolError TRUe TRue True true truE trUE tRUE fALSE faLSE falSE falsE false False FAlse FALse FALSe
" Load functions file
let g:rfunfile = expand("<sfile>:h:h:h") . "/tools/rfunctions"
if filereadable(g:rfunfile)
  exe "source " . g:rfunfile
endif
syn keyword rPreProc     library require

" Error
syn region rRegion matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ transparent contains=ALLBUT,rError,rBraceError,rCurlyError fold
syn region rRegion matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ transparent contains=ALLBUT,rError,rBraceError,rParenError fold
syn region rRegion matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ transparent contains=ALLBUT,rError,rCurlyError,rParenError
syn match rError      /[)\]}]/
syn match rBraceError /[)}]/ contained
syn match rCurlyError /[)\]]/ contained
syn match rParenError /[\]}]/ contained

hi def link rDollar SpecialChar
hi def link rSpecial SpecialChar
hi def link rFunction Function
hi def link rOperator Operator
hi def link rPreProc PreProc
hi def link rBoolError Error

