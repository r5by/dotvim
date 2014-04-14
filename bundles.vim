" ***************************************************************************
" This bundle.vim file is used to manage all plugins using Vundle 
"
" @ Maintainer  :	ruby- Li
" @ Last change :	2013 Feb 18
" @ Designed for:   ruby-'s vim on Mac OS X 10.7.5
" @ Get it      :   https://github.com/ruby-/ruby--s-toolcrib.git
" ***************************************************************************
"
" Required by Bundle
" Use IMproved
    set nocompatible
" Bundle manage support {
    filetype on    
    filetype off " required for Vundle
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'
"}

" ------------------------------------
"   Code completions
" ------------------------------------
    "Bundle 'AutoComplPop'
    "   --try YouCompleteMe
    Bundle 'Valloric/YouCompleteMe'

    "Bundle 'garbas/vim-snipmate'
    "   --try ultisnips
    Bundle 'SirVer/ultisnips'

"Using snipmate
" ---- snipmate dependencies ----
    Bundle 'MarcWeber/vim-addon-mw-utils'
    Bundle 'tomtom/tlib_vim'
    Bundle 'honza/vim-snippets'


" ------------------------------------
"   Fast navigation
" ------------------------------------
    Bundle 'Lokaltog/vim-easymotion'

" ------------------------------------
"   IDE like
" ------------------------------------
    Bundle 'kien/ctrlp.vim'
    Bundle 'Lokaltog/vim-powerline'

" ------------------------------------
"   Syntax related
" ------------------------------------
    Bundle 'plasticboy/vim-markdown'

" ------------------------------------
"   Editing 
" ------------------------------------
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'tpope/vim-surround'
    Bundle 'godlygeek/tabular'

    " --------------------------------
    "   For .markdown files
    "   > ruby gems dependencies:
    "   > sudo gem install github-markup
    " --------------------------------
    Bundle 'matthias-guenther/hammer.vim'

" ------------------------------------
"   Color Schemes 
" ------------------------------------
    Bundle 'altercation/vim-colors-solarized'

" ------------------------------------
"   Optional
" ------------------------------------
    Bundle 'corntrace/bufexplorer'

filetype plugin indent on " Required by Vundle 
