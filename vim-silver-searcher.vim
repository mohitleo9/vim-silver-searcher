function! GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    " set the search register for the word
    let @/ = @@

    silent execute "Ack --" . &filetype . " " . shellescape(@@) . " ."

    let @@ = saved_unnamed_register
endfunction

nnoremap g/ :set operatorfunc=GrepOperator<cr>g@
vnoremap g/ :<c-u>call GrepOperator(visualmode())<cr>
