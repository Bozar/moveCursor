" move cursor "{{{1

" Last Update: Nov 22, Sat | 13:43:24 | 2014

" functions {{{2

function moveCursor#KeepPos(when) "{{{3

    if a:when == 0

        let g:CurrentCursor_moveCursor
        \ = getpos('.')

        let g:TopCursor_moveCursor = getpos('w0')

        call setpos('.',
        \ g:CurrentCursor_moveCursor)

    elseif a:when == 1

        call setpos('.',
        \ g:TopCursor_moveCursor)

        execute 'normal zt'

        call setpos('.',
        \ g:CurrentCursor_moveCursor)

    endif

endfunction "}}}3

function moveCursor#SetMarkJKPara() "{{{3

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

function moveCursor#SetMarkJKFold() "{{{3

    let l:line = line('.')
    let l:save = &foldenable

    set foldenable
    execute l:line
    let l:level = foldlevel(l:line)

    if moveCursor#DetectFold() == 1

        let &foldenable = l:save
        return 1

    endif

    call moveCursor#GotoFoldBegin()

    mark j
    execute 'normal ]z'
    mark k

    let &foldenable = l:save

endfunction "}}}3

function moveCursor#SetMarkJKWhole() "{{{3

    1mark j
    $mark k

endfunction "}}}3

function moveCursor#DetectMarkJK() "{{{3

    if line("'j") == 0

        echo 'ERROR: Mark j not found!'
        return 1

    endif

    if line("'k") == 0

        echo 'ERROR: Mark k not found!'
        return 2

    endif

endfunction "}}}3

function moveCursor#DetectFold() "{{{3

    if foldlevel('.') < 1

        echo 'ERROR: Fold not found!'
        return 1

    endif

endfunction "}}}3

function moveCursor#GotoColumn1(line,mode) "{{{3

    if a:mode == 'str'

        call setpos('.',[0,line(a:line),1,0])

    elseif a:mode == 'num'

        call setpos('.',[0,a:line,1,0])

    endif

endfunction "}}}3

function moveCursor#GotoFoldBegin() "{{{3

    let l:line = line('.')
    let l:level = foldlevel(l:line)

    execute 'normal [z'

    if foldlevel('.') != l:level

        execute l:line

    endif

endfunction "}}}3

 "}}}2
" vim: set fdm=marker fdl=20 tw=50: "}}}1
