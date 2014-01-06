""" Library of commands
command! -nargs=* -bang -bar SetWhitespace call <SID>SetWhitespace('<bang>', <f-args>) "{{{1
function! s:SetWhitespace(bang, ...)
    if a:0
        let local = empty(a:bang) ? 'local' : ''
        execute 'set' . local . ' shiftwidth=' . a:1
        execute 'set' . local . ' softtabstop=' . a:1
        execute 'set' . local . ' tabstop=' . (a:0 == 2 ? a:2 : a:1)
    else
        echo 'sw=' . &shiftwidth . ' sts=' . &softtabstop . ' ts=' . &tabstop
    endif
endfunction

function! VimFoldExpr(lnum) "{{{1
    let line = getline(a:lnum)
    if line =~# '\v\{\{\{\d*\s*$'
        return '>1'
    elseif line =~# '\v^\s*aug%[roup] END'
        return '='
    elseif line =~# '\v^\s*(fu%[nction]|com%[mand]|aug%[roup])'
        return '>1'
    elseif line[0] ==# '"' && getline(a:lnum - 1)[0] !=# '"'
        return '>1'
    else
        return '='
    endif
endfunction

function! VimHelpFoldExpr(lnum) "{{{1
    let line = getline(a:lnum)
    if line =~# '\v\*\S+\*\s*$'
        return getline(a:lnum - 1) =~# '\v\*\S+\*\s*$' ? '=' : '>1'
    elseif line =~# '\v\~$'
        return '>1'
    else
        return '='
    endif
endfunction

function! LispFoldExpr(lnum) "{{{1
    let line = getline(a:lnum)
    if line[0] ==# '('
        return '>1'
    elseif line[0] ==# ';' && getline(a:lnum - 1)[0] !=# ';'
        return '>1'
    else
        return '='
    endif
endfunction

command! -bar LispBufferSetup call <SID>LispBufferSetup() "{{{1
function! s:LispBufferSetup()
    let b:loaded_delimitMate = 1
    SetWhitespace 2 8
    setlocal foldmethod=expr foldexpr=LispFoldExpr(v:lnum)

    " Rainbow parens
    call rainbow_parentheses#load(0)
    call rainbow_parentheses#load(1)
    call rainbow_parentheses#load(2)
    call rainbow_parentheses#activate()

    noremap  <silent><buffer> <4-CR> A<Space>;<Space>
    noremap! <silent><buffer> <4-CR> <C-\><C-o>A<Space>;<Space>
endfunction

command! -bar ClojureBufferSetup call <SID>ClojureBufferSetup() "{{{1
function! s:ClojureBufferSetup()
    LispBufferSetup

    vmap     <silent><buffer> <Leader><Leader> <Plug>FireplacePrint
    nmap     <silent><buffer> <Leader><Leader> <Plug>FireplacePrint<Plug>(sexp_outer_list)``
    imap     <silent><buffer> <Leader><Leader> <C-\><C-o><C-\><C-n><Leader><Leader>

    nmap     <silent><buffer> <Leader>X        <Plug>FireplacePrint<Plug>(sexp_outer_top_list)``
    imap     <silent><buffer> <Leader>X        <C-\><C-o><C-\><C-n><Leader>X

    nmap     <silent><buffer> <Leader>x        <Plug>FireplacePrint<Plug>(sexp_inner_element)``
    imap     <silent><buffer> <Leader>x        <C-\><C-o><C-\><C-n><Leader>x

    nnoremap <silent><buffer> <Leader>r        :Require<CR>
    nnoremap <silent><buffer> <Leader>R        :call fireplace#eval('(user/refresh)')<CR>
    nnoremap <silent><buffer> <LocalLeader>C   :Connect<Space>
    nnoremap <silent><buffer> <LocalLeader>cp  :call fireplace#eval('(user/classpath)')<CR>
    nnoremap <silent><buffer> <LocalLeader>cs  :call <SID>ClojureCheatSheet('.')<CR>
    nnoremap <silent><buffer> <LocalLeader>cS  :call <SID>ClojureCheatSheet(input('Namespace filter: '))<CR>
    nnoremap <silent><buffer> <LocalLeader>e   :call <SID>ClojurePprint('*e')<CR>
    nnoremap <silent><buffer> <LocalLeader>l   :Last<CR>
    nnoremap <silent><buffer> <LocalLeader>m1  :call <SID>ClojureMacroexpand(0)<CR>
    nnoremap <silent><buffer> <LocalLeader>me  :call <SID>ClojureMacroexpand(1)<CR>
    nnoremap <silent><buffer> <LocalLeader>mE  :call <SID>ClojureMacroexpand(2)<CR>
    nnoremap <silent><buffer> <LocalLeader>p   :call <SID>ClojurePprint('*1')<CR>
    nnoremap <silent><buffer> <LocalLeader>R   :Repl<CR>
    nnoremap <silent><buffer> <LocalLeader>r   :ReplHere<CR>
    nnoremap <silent><buffer> <LocalLeader>ss  :call fireplace#eval('(user.system/boot)')<CR>
    nnoremap <silent><buffer> <LocalLeader>sS  :call fireplace#eval('(user.system/stop)')<CR>
    nnoremap <silent><buffer> <LocalLeader>sr  :call fireplace#eval('(user.system/restart)')<CR>
    nnoremap <silent><buffer> <LocalLeader>si  :call <SID>ClojurePprint('@user.system/instance')<CR>
    nnoremap <silent><buffer> <LocalLeader>sl  :call <SID>ClojurePprint('@system/log')<CR>
    nnoremap <silent><buffer> <LocalLeader>sc  :call <SID>ClojurePprint('system/config')<CR>
    nnoremap <silent><buffer> <LocalLeader>sh  :Slamhound<CR>
    nnoremap <silent><buffer> <LocalLeader>st  :call <SID>ClojureStackTrace()<CR>
    nnoremap <silent><buffer> <LocalLeader>tr  :call fireplace#eval('(user/toggle-warn-on-reflection!)')<CR>
    nnoremap <silent><buffer> <LocalLeader>ts  :call <SID>ClojureTypeScaffold()<CR>
    nnoremap <silent><buffer> <LocalLeader>tt  :call <SID>ClojureRunTests(0)<CR>
    nnoremap <silent><buffer> <LocalLeader>tT  :call <SID>ClojureRunTests(1)<CR>
    nnoremap <silent><buffer> <LocalLeader>tv  :call fireplace#eval('(user/toggle-schema-validation!)')<CR>
    nnoremap <silent><buffer> <LocalLeader>tw  :call fireplace#eval('(user/toggle-warnings! true)')<CR>
    nnoremap <silent><buffer> <LocalLeader>tW  :call fireplace#eval('(user/toggle-warnings! false)')<CR>
    nnoremap <silent><buffer> <LocalLeader>u   :call fireplace#eval('(load-file "' . expand('~/.lein/user.clj') . '")')<CR>
endfunction

function! s:ClojurePprint(expr)
    silent call fireplace#eval('(do (clojure.pprint/pprint (do ' . a:expr . ')) ' . a:expr . ')')
    Last
    normal! yG
    pclose
    Sscratch
    setfiletype clojure
    execute "normal! gg\"_dGVPG\"_dd"
    wincmd L
endfunction

function! s:ClojureStackTrace()
    silent call fireplace#eval('(clojure.stacktrace/e)')
    Last
    wincmd L
endfunction

function! s:ClojureCheatSheet(pattern)
    if empty(a:pattern) | return | endif

    let file = fireplace#evalparse('(user/write-cheat-sheet! #"' . escape(a:pattern, '"') . '")')

    if empty(file)
        redraw! " Clear command line
        echo "No matching namespaces."
    else
        execute 'vsplit ' . file . ' | wincmd L'
    endif
endfunction

function! s:ClojureMacroexpand(once)
    let reg_save = @m
    let expand = ['macroexpand-1', 'macroexpand', 'clojure.walk/macroexpand-all'][a:once]
    execute "normal \"my\<Plug>(sexp_outer_list)"
    call s:ClojurePprint('(' . expand . ' (quote ' . @m . '))')
    wincmd L
    let @m = reg_save
endfunction

function! s:ClojureRunTests(all)
    if a:all
        Require!
        call fireplace#eval('(clojure.test/run-all-tests)')
    else
        call fireplace#eval('(user/run-tests-for-current-ns)')
    endif
endfunction

function! s:ClojureTypeScaffold()
    try
        let reg_save = [@e, @r]
        execute "normal \"ey\<Plug>(sexp_inner_element)"
        redir @r
        call fireplace#eval('(println (user/object-scaffold ' . @e . '))')
    finally
        redir END
        Sscratch
        wincmd L
        setfiletype clojure
        normal! gg"_dG"rPdd
        let [@e, @r] = reg_save
    endtry
endfunction

command! -nargs=? -complete=shellcmd -bar Screen call <SID>Screen(<q-args>) "{{{1
function! s:Screen(command)
    let map = {
        \ 'ruby'       : 'irb',
        \ 'clojure'    : 'lein REPL',
        \ 'python'     : 'python',
        \ 'scheme'     : 'scheme',
        \ 'haskell'    : 'ghci',
        \ 'javascript' : 'node'
        \ }
    let cmd = empty(a:command) ? (has_key(map, &filetype) ? map[&filetype] : '') : a:command
    execute 'ScreenShell ' . cmd
endfunction
