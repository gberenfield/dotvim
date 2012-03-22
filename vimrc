" call pathogen#runtime_append_all_bundles() 
" call pathogen#helptags()
" going to Vundle https://github.com/gmarik/vundle

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
" set listchars=tab:»·
set listchars=tab:\ \·
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
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
end
map <leader><leader> <Plug>PeepOpen
" end

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

" vimclojure settings
let vimclojure#HighlightBuiltins = 1
let vimclojure#WantNailgun = 1
" let vimclojure#NailgunClient = "/Users/mc/.vim/bundle/vimclojure/client/ng"
nmap <Leader>rT :call vimclojure#RunTests('n')<CR>

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
" " let g:paredit_mode = 0

" Rainbox Parentheses {{{
" map <F3> :RainbowParenthesesToggle<cr>

" VimClojure ParenRainbow coloring
let g:vimclojure#ParenRainbow = 1
" VimClojure DynamicHighlight.. not sure what I gain here..
let g:vimclojure#DynamicHighLighting = 1
" VimClojure's indenting ala 'lispwords'
let vimclojure#FuzzyIndent = 1
" per sjl's vimrc
let vimclojure#HighlightBuiltins = 1
let vimclojure#WantNailgun = 1

" Yankring
let g:yankring_history_file = '.yankring_history'
let g:yankring_manual_clipboard_check = 0

" " TSlime
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

