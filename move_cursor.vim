" move cursor {{{1

function KeepPos_MoveCursor(when) "{{{

	if a:when == 0
		let g:CurrentCursor_MoveCursor
		\ = getpos('.')
		let g:TopCursor_MoveCursor = getpos('w0')
		call setpos('.',
		\g:CurrentCursor_MoveCursor)

	elseif a:when == 1
		call setpos('.',
		\g:TopCursor_MoveCursor)
		exe 'normal zt'
		call setpos('.',
		\g:CurrentCursor_MoveCursor)

	endif

endfunction "}}}

function FoldBegin_MoveCursor() "{{{

	if substitute(getline('.'),
		\'{\{3}\d\{0,2}$','','') != getline('.')
		+1
	endif

endfunction "}}}

 "}}}1
