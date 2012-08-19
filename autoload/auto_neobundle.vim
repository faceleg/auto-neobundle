" coding: utf-8

if exists("g:auto_neobundle_loaded")
    finish
endif
let g:auto_neobundle_loaded = 1

" 行連結を使っていないので save_cpo は必要ない
" :help use-cpo-save

" set timestamp file location
if !exists("g:auto_neobundle_timestamp_dir")
    let g:auto_neobundle_timestamp_dir = expand('~/.vim')
endif

" Update plugins with neobundle if tics seconds have passed.
function! auto_neobundle#update(tics)
    let stamp_file = g:auto_neobundle_timestamp_dir . '/.auto_neobundle_timestamp'
    let stamp = filereadable(stamp_file) ? readfile(stamp_file)[0] : 0
    let now = localtime()

    if(now - stamp < a:tics)
        return
    endif

    " update plugins with neobundle.vim
    Unite neobundle/update -hide-source-names -buffer-name=auto-neobundle -winheight=1 -auto-quit

    execute "redir! > ".stamp_file
        silent! echon now
    redir END
endfunction

" check daily
function! auto_neobundle#update_daily()
    " 86400 seconds/day
    call auto_neobundle#update(86400)
endfunction

" check weekly
function! auto_neobundle#update_weekly()
    " 604800 seconds/weekly
    call auto_neobundle#update(604800)
endfunction

function! auto_neobundle#update_30days()
    " 2592000 seconds/30days
    call auto_neobundle#update(2592000)
endfunction
