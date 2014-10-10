" detect cursor position "{{{1

function CursorAtFoldBegin() "{{{

	if substitute(getline('.'),
		\'{\{3}\d\{0,2}$',
		\'','')
		\ != getline('.')
		+1
	endif

endfunction "}}}

 "}}}1
