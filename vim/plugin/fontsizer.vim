let s:pattern = '^\(.*\):h\(.*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16

function! AdjustFontSize(amount)
	 let fontname = substitute(&guifont, s:pattern, '\1', '')
	 let cursize = substitute(&guifont, s:pattern, '\2', '')
	 let newsize = cursize + a:amount
	 if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . ":h" . newsize
      let &guifont = newfont
    endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

