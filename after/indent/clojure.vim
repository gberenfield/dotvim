let loaded_clojurefolding=1

" ---------------------------------------------------------------------------
"  Automagic Clojure folding on defn's and defmacro's

function CompareLispword(line)
  "" Defintions: what to fold?
  let foldwords="def,ns"
  ""

  let fwc = split(foldwords,",")

  for fw in fwc
    if a:line =~ '^\s*('.fw.'.*\s'
      return 1
    endif
  endfor
endfunction

function GetClojureFold()
      if CompareLispword(getline(v:lnum))
        return ">1"
      elseif getline(v:lnum) =~ '^\s*$'
            let my_cljnum = v:lnum
            let my_cljmax = line("$")

            while (1)
                  let my_cljnum = my_cljnum + 1
                  if my_cljnum > my_cljmax
                        return "<1"
                  endif

                  let my_cljdata = getline(my_cljnum)

                  " If we match an empty line, stop folding
                  if my_cljdata =~ '^$'
                        return "<1"
                  else
                        return "="
                  endif
            endwhile
      else
            return "="
      endif
endfunction

function TurnOnClojureFolding()
      setlocal foldexpr=GetClojureFold()
      setlocal foldmethod=expr
endfunction

augroup ft_clojure
    au!

    au BufNewFile,BufRead riemann.config set filetype=clojure
    au FileType clojure silent! call TurnOnClojureFolding()
    au FileType clojure setlocal report=100000
    au FileType clojure setlocal lispwords+=defroutes
augroup END


