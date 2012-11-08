set number
set showmode

" highlight what is found searching, but clear the highlight after a return
" press
set hlsearch
nnoremap <CR> :nohlsearch<CR>/<BS>

set showmatch
set incsearch
set ruler
set nocompatible
set backspace=indent,eol,start
set mouse=a
set scrolloff=3

" indentation settings
set smartindent
set shiftwidth=3
set tabstop=3
set softtabstop=3
set expandtab
" end indentation settings

set t_Co=256
set guifont=Monaco:h12:
set hidden
syntax enable
set background=dark
colorscheme solarized 
let mapleader=","


inoremap jk <esc>
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>



" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

 " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END


  autocmd FileType ruby set ai sw=2 sts=2 et


else

  set autoindent                " always set autoindenting on

endif " has("autocmd")
