" -----------------------------------------------------------------------------
" Filename: .vimrc
" Modified: So 25 Okt 2015, 21:29
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details
" -----------------------------------------------------------------------------

" ---------------------------------------------------------------------- Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" File browser
Bundle 'scrooloose/nerdtree'
" Color theme
Bundle 'NLKNguyen/papercolor-theme'
" Automatic completion with Tab
Bundle 'ervandew/supertab'
" Automatic formatting of table structure
Bundle 'godlygeek/tabular'
" Code overview (methods / members)
Bundle 'vim-scripts/taglist.vim'
" ToDo list from code comments
Bundle 'vim-scripts/TaskList.vim'
" Commenting
Bundle 'tomtom/tcomment_vim'
" Pimped status and buffer bars
Bundle 'bling/vim-airline'
" Kill buffer w/o closing window
Bundle 'qpkorr/vim-bufkill'
" Switch between .h/.cpp
Bundle 'derekwyatt/vim-fswitch'
" Git support
Bundle 'tpope/vim-fugitive'
" Basic configuration
Bundle 'tpope/vim-sensible'
" Snippets
Bundle 'honza/vim-snippets'
" Automatic completion
Bundle 'Valloric/YouCompleteMe'
" Ultimate snipping solution
Bundle 'SirVer/ultisnips'
" let Vundle manage itself
Bundle 'gmarik/Vundle.vim'
" File templates
Bundle 'aperezdc/vim-template'

call vundle#end()            " required

" ------------------------------------------------------------------ Formatting
" based on filetype
filetype plugin indent on
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

set nowrap
set tabstop     =3
set shiftwidth  =3
set softtabstop =0
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
set modeline        " Allow file inline modelines to provide settings
set formatoptions=rocq
                    " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " a         Automatically format paragraphs
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode.
                    " o         Automatically insert comment leader after 'o' or 
                    " q         Allow formatting of comments with "gq".
                    " 'O'
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
                    " w         A trailing non-white space ends a paragraph.

" ------------------------------------------------------------------- Interface
set mouse=a
set number
set statusline=%f%m%h%r%w%y[%l/%L,%c%V]%=[%{&fo}]%y[%{&ff}][%{&fenc==\"\"?&enc:&fenc}]
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.

" --------------------------------------------------------------------- GUI-Vim
set guifont=Envy\ Code\ R\ for\ Powerline\ 11
set guioptions-=rL

" ------------------------------------------------------------------- Searching
set nohlsearch      " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
" ----------------------------------------------------------- tags & completion
set tags += ~/.vim/tags/cpp

" ------------------------------------------------------------------ Completion
"set omnifunc=syntaxcomplete#Complete
"set completeopt=longest,menuone
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" ---------------------------------------------------------------------- Colors
syntax enable
set bg=light
set t_Co=256
colorscheme PaperColor

" Mark columns 80 and 120+
"let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(120,999),",")
set cursorline

" --------------------------------------------------------------------- airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='PaperColor'

" --------------------------------------------------------------------- Folding
set foldmethod           =syntax
set foldlevelstart       =99
let perl_fold            =1
let perl_fold_blocks     =1
let sh_fold_enabled      =1
let perl_extended_vars   =1
let perl_sync_dist       =250
let g:xml_syntax_folding =1

" --------------------------------------------------------------------- Taglist
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File    = 1

" -------------------------------------------------------------------  Tasklist
let g:tlWindowPosition=1                      " display at bottom
let g:tlTokenList = ['TODO', 'FIXME', 'XXX']  " search tags

" -------------------------------------------------------------------- fugitive
set diffopt+=vertical

" ------------------------------------------------------------- Extern programs
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*


" ------------------------------------------------------------------- Functions
" If buffer modified, update any 'Modified: ' in the first 20 lines.
" 'Modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    exe '1,' . n . 's#^\(.\{,20}Modified:\s\+\).*#\1' .
          \ strftime('%a %d %b %Y, %H:%M') . '#e'
    exe '1,' . n . 's#^\(.\{,20}Last Change:\s\+\).*#\1' .
          \ strftime('%a %d %b %Y, %H:%M') . '#e'
    exe '1,' . n . 's#^\(.\{,20}@date\s\+\).*#\1' .
          \ strftime('%a %d %b %Y, %H:%M') . '#e'
    call setpos('.', save_cursor)
  endif
endfun
function! ToggleBg()
   let &bg = ( &bg == "dark" ? "light" : "dark" )
endfun
autocmd BufWritePre * call LastModified()

" ----------------------------------------------------------- Keyboard mappings
let mapleader=","
map <Shift-Enter> O<Esc>
map <Enter> o<Esc>
" move by display lines instead of logical lines
nmap <silent> j gj
nmap <silent> k gk


nnoremap <silent> <C-Up> :bp<CR>             " Previous buffer (bufkill)
nnoremap <silent> <C-Down> :bn<CR>           " Next buffer (bufkill)

nnoremap <silent> <F3> :FSHere<CR>           " Toggle h / cpp (FSwitch)
nnoremap <silent> <F4> :call ToggleBg()<CR>  " Toggle background lightness
nnoremap <silent> <F5> :setlocal spell! spelllang=en_us<cr> " Toggle spellcheck
nnoremap <silent> <F6> :BD<CR>               " Close buffer (bufkill)
nnoremap <silent> <F7> :NERDTreeToggle<CR>   " Toggle Nerdtree
nnoremap <silent> <F8> :TlistToggle<CR>      " Toggle Taglist
nnoremap <silent> <F9> :TaskList<CR>         " Open TaskList window
nnoremap <silent> <F10> :e ~/.vimrc<CR>      " Open Settings

" ------------------------------------------------------------ Private settings
source ~/.vim/private

" ----------------------------------------------------------------- GPG editing
let g:GPGPreferArmor=1
let g:GPGDefaultRecipients=["philipp.blanke@googlemail.com"]
let g:GPGPreferSymmetric=1
let g:GPGUsePipes=1

