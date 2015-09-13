if exists('g:mapCommandOpLoaded') || (v:version < 700)
    finish
endif
let g:mapCommandOpLoaded = 1

function! mapOp#createOp(command)
    norm! gv
    execute "norm! " . a:command
    call mapOp#popVis()
endfunction
function! mapOp#mapOp(map, function)
    exec 'nnoremap <silent>' . a:map . ' <esc>:call mapOp#pushVis()<cr>:set opfunc='. a:function.'<cr>g@'
endfunction
function! mapOp#pushVis()
    let g:mapOp#VisualStart = getpos("'<")
    let g:mapOp#VisualEnd = getpos("'>")
endfunction
function! mapOp#popVis()
    call setpos("'<", g:mapOp#VisualStart)
    call setpos("'>", g:mapOp#VisualEnd)
endfunction
func! mapOp#zcOp(type)
    call mapOp#createOp("zc")
endfunction
func! mapOp#zCOp(type)
    call mapOp#createOp("zC")
endfunction
func! mapOp#zoOp(type)
    call mapOp#createOp("zo")
endfunction
func! mapOp#zOOp(type)
    call mapOp#createOp("zO")
endfunction
func! mapOp#zDOp(type)
    call mapOp#createOp("zD")
endfunction
if (!exists("g:mapCommandOpNoDefaults")||!g:mapCommandOpNoDefaults)
    call mapOp#mapOp("zc", "mapOp#zcOp")
    call mapOp#mapOp("zC", "mapOp#zCOp")
    call mapOp#mapOp("zo", "mapOp#zoOp")
    call mapOp#mapOp("zO", "mapOp#zOOp")
    call mapOp#mapOp("zD", "mapOp#zDOp")
    nnoremap zcc :norm! zc<cr>
    nnoremap zCC :norm! zC<cr>
    nnoremap zoo :norm! zo<cr>
    nnoremap zOO :norm! zO<cr>
    nnoremap zDD :norm! zD<cr>
endif
 
 
 
