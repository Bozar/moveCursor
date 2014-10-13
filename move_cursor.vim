" move cursor {{{1

function move_cursor#KeepPos(when) "{{{

	if a:when == 0
		let g:CurrentCursor_MoveCursor
		\ = getpos('.')
		let g:TopCursor_MoveCursor = getpos('w0')
		call setpos('.',
		\g:CurrentCursor_MoveCursor)

	elseif a:when == 1
		call setpos('.',
		\g:TopCursor_MoveCursor)
		execute 'normal zt'
		call setpos('.',
		\g:CurrentCursor_MoveCursor)

	endif

endfunction "}}}

function move_cursor#Para_SetMarkJK() "{{{

	if line("'{") == 1
		'{
		mark j
		" } bracket pair
	else
		'{+1
		mark j
		" } bracket pair
	endif
	if line("'}") == line('$')
		'}mark k
	else
		'}-1mark k
	endif

endfunction "}}}

 "}}}1
