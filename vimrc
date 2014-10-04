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


" ZoomWin configuration
map <Leader>c :ZoomWin<CR>


" Ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'file': '\.so$\|\.swp$\|\.zip$|\.lock$\|\.bz2$\|\.jar$\|\.class$\|\.scssc$\|\.png$\|\.jpg$',
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|tmp$|cache',
  \ }
let g:ctrlp_map = '<leader><leader>'
nmap <leader><space> :CtrlPBuffer<CR>

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
let g:syntastic_enable_signs = 1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_enable_highlighting = 1

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

" 256 colors, dark bankground, get our theme ready
set t_Co=256
set background=dark

" Default color scheme
" colorscheme af
" colorscheme ir_black
" colorscheme molokai
colorscheme badwolf
let g:badwolf_tabline = 2
let g:badwolf_html_link_underline = 0

" Airline powerline plugin
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Yankring
let g:yankring_history_file = '.yankring_history'
" let g:yankring_manual_clipboard_check = 0

" something to tinker with, just in case fakeclip fails...
function! g:CopyTheTextPlease()
    let old_z = @z
    normal! gv"zy
    call system('pbcopy', @z)
    let @z = old_z
endfunction
" map PP to paste in system/linux clipboard, trying fakeclip
nmap PP "*p


" " " Better Rainbow Parentheses
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
" " au BufNewFile,BufReadPost *.clj RainbowParenthesesToggle
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" " au Syntax * RainbowParenthesesLoadSquare
" " au Syntax * RainbowParenthesesLoadBraces
" " au BufNewFile,BufReadPost *.clj RainbowParenthesesLoadRound
" " au BufNewFile,BufReadPost *.clj RainbowParenthesesLoadSquare
" " au BufNewFile,BufReadPost *.clj RainbowParenthesesLoadBraces
" " map <F3> :RainbowParenthesesToggle<cr>

" Coffeescript folding settings
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
" au BufNewFile,BufReadPost *.coffee setlocal foldexpr=getline(v:lnum)=~'->$'&&indent(v:lnum)<indent(v:lnum+1)?'a1':'s1
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent   "fold based on indent
au BufNewFile,BufReadPost *.coffee setl foldnestmax=10      "deepest fold is 10 levels
au bufnewfile,bufreadpost *.coffee setl foldlevel=1         "this is just what i use
au bufnewfile,bufreadpost *.coffee setl foldignore="#"

" per http://vim.wikia.com/wiki/Make_views_automatic
set viewoptions=cursor,folds,slash,unix
let g:skipview_files = ['.git*']

" vim-indent-guides
let g:indent_guides_auto_colors = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" MUTT/e-mail spellchecking
autocmd FileType mail set spell
autocmd FileType mail setlocal fo+=aw
autocmd FileType mail set textwidth=120

" XML lint the xml
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Vimwiki wiki  settings
autocmd FileType vimwiki set textwidth=120

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=json

" \jt for re-formatting json. Doing a direct call instead of 'python -m
" json.dump' for 2-space indents vs 4.
nmap <leader>jt <Esc>:%!python -c "exec(\"import sys\nimport json\njson.dump(json.load(sys.stdin),sys.stdout,sort_keys=True,indent=2)\")"<CR><Esc>:set filetype=json<CR>

" my tab mappings
nnoremap tt :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap t] :tabn<CR>
nnoremap t[ :tabp<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Mac-specific ala sjl
" Copying text to the system clipboard.
"
" For some reason Vim no longer wants to talk to the OS X pasteboard through "*.
" Computers are bullshit.
function! g:FuckingCopyTheTextPlease()
    let old_z = @z
    normal! gv"zy
    call system('pbcopy', @z)
    let @z = old_z
endfunction
noremap <leader>p :silent! set paste<CR>"*p:set nopaste<CR>
noremap <leader>p :r!pbpaste<cr>
vnoremap <leader>y :<c-u>call g:FuckingCopyTheTextPlease()<cr>

" C-Language
" au FileType c setlocal fdm=syntax
au FileType c setlocal foldmethod=marker
au FileType c setlocal foldmarker={,}

" Bash/SH
au FileType sh setlocal foldmethod=marker
au FileType sh setlocal foldmarker={,}

let g:netrw_browserx_viewer="dwb"

" Sass/SCSS
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}

" vcards
au BufNewFile,BufRead *.vcf set filetype=vcard
" adr
au BufNewFile,BufRead *.adr set filetype=adr
au FileType adr set foldmethod=syntax

" Clojure folding settings
let g:clojure_foldwords = "def,ns,comment,add-filter!"
" Clojure filetype for cljx files.. not great but until better comes along...
au BufNewFile,BufRead *.cljx set filetype=clojure

" vim-fireplace
" evulate inner () with 'cpc'
au BufNewFile,BufRead *.clj,*.cljs,*.cljx map cpc cpa)

"vim-slamhound for clojure
nnoremap <LocalLeader>sh :Slamhound<CR>

" Plugin: vim-clojure-static
let g:clojure_align_multiline_strings = 1
let g:clojure_fuzzy_indent_patterns = [
    \ '^with-', '^def', '^let', '^when-', 'ing$', '-for$', '^for-',
    \ '^fn', '-fn$', '^at-', '-to$', '-loop$', '\v(cond|as)-\>\*', '^dosql$'
    \ ]
let g:clojure_fuzzy_indent_blacklist = ['\v^with-%(meta|out-str|loading-context)$']

" " guns vim stuff for clojure, salt to taste
" autocmd FileType clojure ClojureBufferSetup
" source ~/.vim/local/commands.vim

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
source ~/.vim/vimrc.private

if has('gui_running')
    source ~/.vim/local/gvimrc.vim
else
    source ~/.vim/local/tty.vim
endif

" Open markdown files with dwb. uses 'python_markdown' package in Arch
autocmd BufEnter *.md exe 'noremap <F5> :!markdown_py %:p >/tmp/md-temp.html; dwb /tmp/md-temp.html<CR>'
