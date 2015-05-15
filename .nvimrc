" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
       
set tabstop=2       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
set showcmd         " Show (partial) command in status line.
set number          " Show line numbers.
set relativenumber  " Show relative line numbers for easy jumping
set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
set ignorecase      " Ignore case in search patterns.
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
set backspace=indent,eol,start
"set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.
set formatoptions=croql " = Set formatoptions to croql
                    "c = Auto-wrap comments with textwidth, auto-insert comment char
                    " r = Auto-insert comment char after <Enter> in Insert mode
                    " o = Auto-insert comment char after Opening in Normal mode
                    " q = Allow formatting comments with "gq"
                    " l = Long lines aren't broken in Insert mode

                    " c,q,r " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.
set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.
set hidden					" Allow me to change the damn buffer without saving!

filetype off                   " required!
set nocompatible               " be iMproved

set rtp+=~/.nvim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'
"Plugin "pangloss/vim-javascript"
Plugin 'lukaszb/vim-web-indent'
Plugin 'tpope/vim-fugitive'
Plugin 'jamessan/vim-gnupg'
Plugin 'sophacles/vim-processing'
Plugin 'godlygeek/tabular'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'flazz/vim-colorschemes'
Plugin 'Shougo/vimproc.vim'
let g:haddock_browser = '/usr/bin/firefox'
Plugin 'lukerandall/haskellmode-vim'
au BufEnter *.hs compiler ghc

Plugin 'eagletmt/ghcmod-vim'

Plugin 'scrooloose/syntastic'
let g:syntastic_c_include_dirs = ['/usr/include/SDL2']

Plugin 'Shougo/neocomplcache'
Plugin 'ujihisa/neco-ghc'

Plugin 'bling/vim-airline'

call vundle#end()

syntax on
filetype plugin indent on 

set laststatus=2

"set t_Co=256
"colorscheme darkZ
"colorscheme lucius
"set makeprg=ccmake

