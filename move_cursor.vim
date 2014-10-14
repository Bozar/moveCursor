" move cursor "{{{1

" Last Update: Oct 14, Tue | 08:03:50 | 2014

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

function move_cursor#Fold_SetMarkJK() "{{{

	let l:line = line('.')
	let l:save = &foldenable

	set foldenable
	execute l:line
	let l:level = foldlevel(l:line)

	if l:level == 0
		let &foldenable = l:save
		return 1
	endif

	execute 'normal [z'
	if foldlevel('.') != l:level
		execute l:line
		mark j
	else
		mark j
	endif

	execute 'normal ]z'
	mark k

	let &foldenable = l:save

endfunction "}}}
 "}}}1
