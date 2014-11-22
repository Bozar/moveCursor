" move cursor "{{{1

" Last Update: Nov 22, Sat | 23:14:23 | 2014

" functions "{{{2

function moveCursor#DetectLineNr(id,echo) "{{{3

    let l:LineNr =
    \ 'g:LineNr' . a:id . '_moveCursor'

    let l:error = 'ERROR:' . ' ' . l:LineNr
    let l:error .= " doens't exist!"

    if !exists(l:LineNr)

        if a:echo > 0

            echo l:error

        endif

        return 1

    else

        return 0

    endif

endfunction "}}}3

function moveCursor#GetLineNr(expr,id) "{{{3

    execute 'let g:LineNr' . a:id .
    \ '_moveCursor =' . ' ' . line(a:expr)

endfunction "}}}3

" SetRangeLine() "{{{3

function moveCursor#SetLineRange(from,to,...)

    execute 'let l:from = g:LineNr' . a:from .
    \ '_moveCursor'

    execute 'let l:to = g:LineNr' . a:to .
    \ '_moveCursor'

    if exists('a:1')

        let l:from = l:from + a:1

    endif

    if exists('a:2')

        let l:to = l:to + a:2

    endif

    let g:LineRange_moveCursor =
    \ l:from . ',' . l:to

endfunction "}}}3

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

function moveCursor#SetLineJKPara() "{{{3

    if getline("'{") != ''

        '{
        call moveCursor#GetLineNr('.','J')
        " } bracket pair

    else

        '{+1
        call moveCursor#GetLineNr('.','J')
        " } bracket pair

    endif

    if getline("'}") != ''

        call moveCursor#GetLineNr("'}",'K')

    else

        call moveCursor#GetLineNr("'}-1",'K')

    endif

endfunction "}}}3

function moveCursor#SetLineJKFold() "{{{3

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

    call moveCursor#GetLineNr('.','J')

    execute 'normal ]z'

    call moveCursor#GetLineNr('.','K')

    let &foldenable = l:save

endfunction "}}}3

function moveCursor#SetLineJKWhole() "{{{3

    let g:LineNrJ_moveCursor = 1

    call moveCursor#GetLineNr('$','K')

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
