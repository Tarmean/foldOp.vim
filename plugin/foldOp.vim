if exists('g:mapCommandOpLoaded') || (v:version < 700)
    finish
endif
let g:mapCommandOpLoaded = 1

function! foldOp#createOp(command)
    norm! gv
    execute "norm! " . a:command
    call foldOp#popVis()
endfunction
function! foldOp#foldOp(map, function)
    exec 'nnoremap <silent>' . a:map . ' <esc>:call foldOp#pushVis()<cr>:set opfunc='. a:function.'<cr>g@'
endfunction
function! foldOp#pushVis()
    let g:foldOp#VisualStart = getpos("'<")
    let g:foldOp#VisualEnd = getpos("'>")
    let g:foldOp#CusorPos = getpos(".")
endfunction
function! foldOp#popVis()
    call setpos("'<", g:foldOp#VisualStart)
    call setpos("'>", g:foldOp#VisualEnd)
    call setpos(".", g:foldOp#CusorPos)
endfunction
func! foldOp#zcOp(type)
    call foldOp#createOp("zc")
endfunction
func! foldOp#zCOp(type)
    call foldOp#createOp("zC")
endfunction
func! foldOp#zoOp(type)
    call foldOp#createOp("zo")
endfunction
func! foldOp#zOOp(type)
    call foldOp#createOp("zO")
endfunction
func! foldOp#zDOp(type)
    call foldOp#createOp("zD")
endfunction
if (!exists("g:mapCommandOpNoDefaults")||!g:mapCommandOpNoDefaults)
    call foldOp#foldOp("zc", "foldOp#zcOp")
    call foldOp#foldOp("zC", "foldOp#zCOp")
    call foldOp#foldOp("zo", "foldOp#zoOp")
    call foldOp#foldOp("zO", "foldOp#zOOp")
    call foldOp#foldOp("zD", "foldOp#zDOp")
    nnoremap zcc :norm! zc<cr>
    nnoremap zCC :norm! zC<cr>
    nnoremap zoo :norm! zo<cr>
    nnoremap zOO :norm! zO<cr>
    nnoremap zDD :norm! zD<cr>
endif
 
 
 
