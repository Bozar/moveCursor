" move cursor "{{{1

" Last Update: Nov 28, Fri | 12:33:22 | 2014

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

" SetLineRange() "{{{3

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

    let l:range = l:from . ',' . l:to

    if exists('a:3')

        exe 'let g:LineRange' . a:3 .
        \ '_moveCursor' .
        \  ' =' . ' ' . string(l:range)

    elseif !exists('a:3')

        let g:LineRange_moveCursor =
        \ l:range

    endif

endfunction "}}}3

function moveCursor#KeepPos(when) "{{{3

    if a:when == 0

        let s:CursorCurrent = getpos('.')

        let s:CursorTop = getpos('w0')

        call setpos('.',s:CursorCurrent)

    elseif a:when == 1

        call setpos('.',s:CursorTop)

        execute 'normal zt'

        call setpos('.',s:CursorCurrent)

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

function moveCursor#GotoColumnEnd(line,mode) "{{{3

    if a:mode == 'str'

        call setpos('.',[0,line(a:line),
        \ search('$','c',line(a:line)),0])

    elseif a:mode == 'num'

        call setpos('.',[0,a:line,
        \ search('$','c',a:line),0])

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

function moveCursor#SearchInLine(pat,move) "{{{3

    if a:move == 'f' || a:move == ''

        let l:noCursorPos = 'W'
        let l:cursorPos = 'cW'

    elseif a:move == 'b'

        let l:noCursorPos = 'bW'
        let l:cursorPos = 'bcW'

    endif

    let l:i = 0

    while l:i < 2

        if search(a:pat,l:noCursorPos,line('.'))
        \ == 0
        \ &&
        \ search(a:pat,l:cursorPos,line('.'))
        \ == 0

            if l:i == 0

                let l:cursor = getpos('.')

                if a:move == 'f' || a:move == ''

                    call
                    \ moveCursor#GotoColumn1(
                    \ '.','str')

                elseif a:move == 'b'

                    call
                    \ moveCursor#GotoColumnEnd(
                    \ '.','str')

                endif

            elseif l:i == 1

                call setpos('.',l:cursor)

            endif

            let l:i = l:i + 1

        else

            break

        endif

    endwhile

endfunction "}}}3

 "}}}2
" vim: set fdm=marker fdl=20 tw=50: "}}}1
