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
    let g:foldOp#oldReg = @y
    norm! qy
endfunction
function! foldOp#popVis()
    norm! q
    if @y != ""
        let g:foldOp#input = @y
    endif
    let @y = exists(g:foldOp#oldReg)? g:foldOp#oldReg : ""
    call setpos("'<", g:foldOp#VisualStart)
    call setpos("'>", g:foldOp#VisualEnd)
    call setpos(".", g:foldOp#CusorPos)
endfunction

function! foldOp#repeatOperator(command)
    exec "norm " . a:command . g:foldOp#input
endfunction

nmap <Plug>foldOp#repeat_zc :call foldOp#repeatOperator("zc")<cr>
func! foldOp#zcOp(type)
    silent! call repeat#set("\<Plug>foldOp#repeat_zc",-1)
    call foldOp#createOp("zc")
endfunction
nmap <Plug>foldOp#repeat_zC :call foldOp#repeatOperator("zC")<cr>
func! foldOp#zCOp(type)
    silent! call repeat#set("\<Plug>foldOp#repeat_zC")<cr>",-1)
    call foldOp#createOp("zC")
endfunction
nmap <Plug>foldOp#repeat_zo :call foldOp#repeatOperator("zo")<cr>
func! foldOp#zoOp(type)
    silent! call repeat#set("\<Plug>foldOp#repeat_zo")<cr>",-1)
    call foldOp#createOp("zo")
endfunction
nmap <Plug>foldOp#repeat_zO :call foldOp#repeatOperator("zO")<cr>
func! foldOp#zOOp(type)
    silent! call repeat#set("\<Plug>foldOp#repeat_zO",-1)
    call foldOp#createOp("zO")
endfunction
func! foldOp#zDOp(type)
    silent! call repeat#set(":call foldOp#repeatOperator("zD")<cr>",-1)
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
 
 
 

