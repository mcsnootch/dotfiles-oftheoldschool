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
set scrolloff=3

" indentation settings
set smartindent
set shiftwidth=3
set tabstop=3
set softtabstop=3
set expandtab
" end indentation settings

set t_Co=256
if has("mac")
   set guifont=Monaco:h12:
endif
if has("gui_win32")
   set guifont=Consolas:h10:
endif
set hidden
syntax enable
set background=dark

try 
   colorscheme solarized 
catch /.*/
   colorscheme desert
endtry

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


function! Putclip(type, ...) range
   let sel_save = &selection
   let &selection = "inclusive"
   let reg_save = @@
   if a:type == 'n'
      silent exe a:firstline . "," . a:lastline . "y"
   elseif a:type == 'c'
      silent exe a:1 . "," . a:2 . "y"
   else
      silent exe "normal! `<" . a:type . "`>y"
   endif
   "call system('putclip', @@)
   "  "As of Cygwin 1.7.13, the
   "  /dev/clipboard device was added
   "  to provide
   "    "access to the native Windows
   "    clipboard. It provides the
   "    added benefit
   "      "of supporting utf-8
   "      characters which putclip
   "      currently does not. Based
   "        "on a tip from John
   "        Beckett, use the
   "        following:
   call writefile(split(@@,"\n"), '/dev/clipboard')
   let &selection = sel_save
   let @@ = reg_save
endfunction

vnoremap <silent> <leader>y :call Putclip(visualmode(), 1)<CR>
nnoremap <silent> <leader>y :call Putclip('n', 1)<CR>

function! Getclip()
   let reg_save = @@
   "let @@ = system('getclip')
   "  "Much like Putclip(), using the /dev/clipboard device to access to
   "  the
   "    "native Windows clipboard for Cygwin 1.7.13 and above. It provides
   "    the
   "      "added benefit of supporting utf-8 characters which getclip
   "      currently does
   "        "not. Based again on a tip from John Beckett, use the
   "        following:
   let @@ = join(readfile('/dev/clipboard'), "\n")
   setlocal paste
   exe 'normal p'
   setlocal nopaste
   let @@ = reg_save
endfunction

nnoremap <silent> <leader>p :call Getclip()<CR>


nmap <C-Up> ddkP
nmap <C-Down> ddjP
vmap <C-Up> xkP`[V`]
vmap <C-down> xjP`[V`]

