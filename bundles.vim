filetype off " required!

set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'L9'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-markdown'
Bundle 'msanders/snipmate.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tsaleh/vim-align'
Bundle 'mileszs/ack.vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'pangloss/vim-javascript'
Bundle 'hallettj/jslint.vim'
Bundle 'ddollar/nerdcommenter'
Bundle 'taglist.vim'
Bundle 'ervandew/supertab'
Bundle 'timcharper/textile.vim'
Bundle 'taq/vim-rspec'
Bundle 'ZoomWin'
Bundle 'tpope/vim-unimpaired'
Bundle 'searchfold.vim'
Bundle 'tpope/vim-endwise'
Bundle 'scrooloose/syntastic'
Bundle 'ajf/puppet-vim'
Bundle 'mattn/gist-vim'
Bundle 'Arduino-syntax-file'
Bundle "c9s/bufexplorer"
Bundle 'tpope/vim-repeat'
Bundle 'tomtom/tcomment_vim'
Bundle 'jQuery'
Bundle 'VimClojure'
Bundle 'benmills/vimux'
" Bundle "slimv.vim"
" Bundle "sjl/tslime.vim"
" tslime can't seem to pass a whole buffer of text to tmux
" Bundle "jpalardy/vim-slime"
" Bundle "gberenfield/sjl-slimv"
" Bundle "chrismetcalf/vim-rainbow"
" Bundle "kien/rainbow_parentheses.vim"
Bundle "sjl/gundo.vim"
Bundle 'YankRing.vim'
Bundle "kien/ctrlp.vim"

" filetype plugins ON
filet plugin on
filetype plugin indent on

