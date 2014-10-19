" move cursor "{{{1

" Last Update: Oct 19, Sun | 18:44:58 | 2014

" functions {{{2

function move_cursor#KeepPos(when) "{{{3

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

endfunction "}}}3

function move_cursor#SetMarkJK_Para() "{{{3

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

endfunction "}}}3

function move_cursor#SetMarkJK_Fold() "{{{3

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

endfunction "}}}3

function move_cursor#SetMarkJK_Whole() "{{{3

	1mark j
	$mark k

endfunction "}}}3

function move_cursor#DeteceMarkJK() "{{{3

	if line("'j") == 0
		echo 'ERROR: Mark j not found!'
		return 1
	endif

	if line("'k") == 0
		echo 'ERROR: Mark k not found!'
		return 2
	endif

endfunction "}}}3

 "}}}2
" vim: set fdm=marker fdl=20 tw=50: "}}}1
