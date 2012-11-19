" Vundle and bundles configuration
source ~/.vim/bundles.vim

" map F2 to clear search text
map <F2> :noh<CR>

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
set scrolloff=3

set number
set ruler
syntax on


" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" set list listchars=tab:\ \ ,trail:·
" http://stackoverflow.com/questions/903934/unable-to-make-gray-eol-character-by-vimrc
set list
set listchars=tab:»·
" set listchars=tab:\ \ 
set listchars+=trail:·
hi NonText ctermfg=7 guifg=gray

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader>] :ZoomWin<CR>

" PeepOpen
" bye peepopen, hi ctrl-p?
" if has("gui_macvim")
"   macmenu &File.New\ Tab key=<nop>
" end
" map <leader><leader> <Plug>PeepOpen
" end

" Ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'file': '\.so$\|\.swp$\|\.zip$|\.lock$\|\.bz2$\|\.jar$\|\.class$\|\.scssc$\|\.png$\|\.jpg$',
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|tmp$|cache',
  \ }
let g:ctrlp_map = '<leader><leader>'


" CTags
" map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function! s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" my ruby specs
au FileType ruby setlocal fdm=syntax
au FileType css setlocal fdm=indent shiftwidth=2 tabstop=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
colorscheme molokai

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Powerline
let g:Powerline_symbols = 'fancy'

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" " SLIMV REPL syntax highlighting
" let g:slimv_repl_syntax = 1
" " let g:lisp_rainbow = 1
" " disable slimv's paredit mode..
let g:paredit_mode = 0
" Use a swank command that works, and doesn't require new app windows.
" let g:slimv_swank_clojure = '!dtach -n /tmp/dtach-swank.sock -r winch lein swank'
let g:slimv_repl_name = 'SLIMV.REPL'
let g:slimv_repl_split = 4
" let g:slimv_repl_syntax = 0
let g:slimv_repl_wrap = 0
" let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"sbcl --load ~/.vim/slime/start-swank.lisp\""'
" let g:slimv_swank_cmd = '! xterm -e sbcl --load ~/.vim/bundle/sjl-slimv/slime/start-swank.lisp &' " crashes on 64-bit macvim :-((
let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"sbcl --load ~/.vim/bundle/sjl-slimv/slime/start-swank.lisp\""'

" Rainbox Parentheses {{{
" map <F3> :RainbowParenthesesToggle<cr>

" vimclojure settings
let vimclojure#WantNailgun=1
" VimClojure ParenRainbow coloring
let g:vimclojure#ParenRainbow=1
" VimClojure DynamicHighlight.. not sure what I gain here..
let g:vimclojure#DynamicHighLighting=1
let g:vimclojure#HighlightBuiltins=1
let vimclojure#HighlightBuiltins = 1
" VimClojure's indenting ala 'lispwords'
let g:vimclojure#FuzzyIndent=1
" per sjl's vimrc
" let vimclojure#NailgunClient = "/Users/".$username."/.vim/bundle/vimclojure/client/ng"
let vimclojure#NailgunClient = $HOME."/.vim/bundle/VimClojure/client/ng"
nmap <Leader>rT :call vimclojure#RunTests('n')<CR>

" Yankring
let g:yankring_history_file = '.yankring_history'
let g:yankring_manual_clipboard_check = 0

" vimux
" Inspect runner pane map
map <Leader>vi :VimuxInspectRunner<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Prompt for a command to run
map <LocalLeader>vp :VimuxPromptCommand<CR>
" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <LocalLeader>vs "vy :call VimuxRunCommand(@v . "\n", 0)<CR>
" Select current paragraph and send it to tmux
nmap <LocalLeader>vs vip<LocalLeader>vs<CR>

" TSlime
" let g:tslime_ensure_trailing_newlines = 1
" let g:tslime_normal_mapping = '<localleader>t'
" let g:tslime_visual_mapping = '<localleader>t'
" let g:tslime_vars_mapping = '<localleader>T'

" " Better Rainbow Parentheses
" let g:rbpt_colorpairs = [
"     \ ['brown',       'RoyalBlue3'],
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgray',    'DarkOrchid3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['gray',        'RoyalBlue3'],
"     \ ['black',       'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['darkred',     'DarkOrchid3'],
"     \ ['red',         'firebrick3'],
"     \ ]
" 
" let g:rbpt_max = 16

" Coffeescript folding settings
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
" au BufNewFile,BufReadPost *.coffee setlocal foldexpr=getline(v:lnum)=~'->$'&&indent(v:lnum)<indent(v:lnum+1)?'a1':'s1
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent   "fold based on indent
au BufNewFile,BufReadPost *.coffee setl foldnestmax=10      "deepest fold is 10 levels
au bufnewfile,bufreadpost *.coffee setl foldlevel=1         "this is just what i use
au bufnewfile,bufreadpost *.coffee setl foldignore="#"

" Clojure folding settings
" au BufNewFile,BufReadPost *.clj setl shiftwidth=2 expandtab nofoldenable
" au BufNewFile,BufReadPost *.clj setl foldmethod=indent   "fold based on indent
" au BufNewFile,BufReadPost *.ccj setl foldnestmax=1      "deepest fold is 10 levels

" per http://vim.wikia.com/wiki/Make_views_automatic
set viewoptions=cursor,folds,slash,unix
let g:skipview_files = ['.git*']

let g:slime_target = "tmux"

" if exists('loaded_clojurefolding') || &cp
"     finish
" endif
let loaded_clojurefolding=1

" ---------------------------------------------------------------------------
"  Automagic Clojure folding on defn's and defmacro's
"
function GetClojureFold()
      if getline(v:lnum) =~ '^\s*(defn.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(def .*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(defmacro.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(ns.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(defmethod.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(defpage.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(defpartial.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(deftest.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(.*defentity.*\s' " for Korma
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
    " au FileType clojure call TurnOnClojureFolding()
    " au FileType clojure compiler clojure
    au FileType clojure setlocal report=100000

    " au BufWinEnter            SLIMV.REPL setlocal nolist
    " au BufNewFile,BufReadPost SLIMV.REPL setlocal nowrap foldlevel=99
    " au BufNewFile,BufReadPost SLIMV.REPL nnoremap <buffer> A GA
    " au BufNewFile,BufReadPost SLIMV.REPL nnoremap <buffer> <localleader>R :emenu REPL.<Tab>

    " " Fix the eval mappings.
    " au FileType clojure nnoremap <buffer> <localleader>ef :<c-u>call SlimvEvalExp()<cr>
    " au FileType clojure nnoremap <buffer> <localleader>ee :<c-u>call SlimvEvalDefun()<cr>

    " " And the inspect mapping.
    " au FileType clojure nmap <buffer> \i \di

    " " And REPL-toggling mapping.
    " " au FileType clojure nnoremap <buffer> \rr :call SlimvToggleRepl()<cr>

    " " Indent top-level form.
    " au FileType clojure nmap <buffer> <localleader>= mz99[(v%='z
augroup END

" vim-indent-guides
let g:indent_guides_auto_colors = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" MUTT/e-mail spellchecking
autocmd FileType mail set spell

