" move cursor "{{{1

" Last Update: Oct 15, Wed | 16:36:56 | 2014

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

	if getline("'{") != ''
		'{
		mark j
		" } bracket pair
	else
		'{+1
		mark j
		" } bracket pair
	endif
	if getline("'}") != ''
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
		echo 'ERROR: Fold not found!'
		return 1
	endif

	execute 'normal [z'
	if foldlevel('.') != l:level
		execute l:line
	endif
	mark j

	execute 'normal ]z'
	mark k

	let &foldenable = l:save

endfunction "}}}

function move_cursor#DeteceMarkJK() "{{{

	if line("'j") == 0
		echo 'ERROR: Mark j not found!'
		return 1
	endif

	if line("'k") == 0
		echo 'ERROR: Mark k not found!'
		return 2
	endif

endfunction "}}}

 "}}}1
