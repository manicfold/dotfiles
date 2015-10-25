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

Bundle 'chriskempson/base16-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/taglist.vim'
Bundle 'SirVer/ultisnips'
Bundle 'bling/vim-airline'
Bundle 'qpkorr/vim-bufkill'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'honza/vim-snippets'
Bundle 'gmarik/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'

"Bundle 'altercation/vim-colors-solarized'

call vundle#end()            " required

" ------------------------------------------------------------------ Formatting
" based on filetype
filetype plugin indent on
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 3>/dev/null

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
set guifont=Envy\ Code\ R\ for\ Powerline\ 11

" ------------------------------------------------------------------- Searching
set nohlsearch      " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
" ----------------------------------------------------------- tags & completion
"set tags=~/.vimtags

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
set bg=dark
set t_Co=256
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-eighties 
"set rtp+=~/.vim/bundle/vim-colors-solarized
"colorscheme solarized
"call togglebg#map("<F4>")
" Mark columns 80 and 120+
"let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(120,999),",")
set cursorline

" -------------------------------------------------------------- basic mappings
let mapleader=","
map <Shift-Enter> O<Esc>
map <Enter> o<Esc>
" move by display lines instead of logical lines
nmap <silent> j gj
nmap <silent> k gk

" Map <F5> to turn spelling on (VIM 7.0+)
map <F5> :setlocal spell! spelllang=en_us<cr>

" --------------------------------------------------------------------- airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1

" --------------------------------------------------------------------- Folding
set foldmethod           =syntax
set foldlevelstart       =99
let perl_fold            =1
let perl_fold_blocks     =1
let sh_fold_enabled      =1
let perl_extended_vars   =1
let perl_sync_dist       =250
let g:xml_syntax_folding =1

" -------------------------------------------------------------------- Nerdtree
nnoremap <silent> <F7> :NERDTreeToggle<CR>

" --------------------------------------------------------------------- Taglist
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File    = 1
nnoremap <silent> <F8> :TlistToggle<CR>

" --------------------------------------------------------------------- FSwitch
nnoremap <silent> <F3> :FSHere<CR>

" --------------------------------------------------------------------- BufKill
nnoremap <silent> <F6> :BD<CR>
nnoremap <silent> <C-Up> :bp<CR>
nnoremap <silent> <C-Down> :bn<CR>


" ------------------------------------------------------------- Extern programs
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*


" """""""""""""""""""""""""""""""" GPG editing
let g:GPGPreferArmor=1
let g:GPGDefaultRecipients=["philipp.blanke@googlemail.com"]
let g:GPGPreferSymmetric=1
let g:GPGUsePipes=1

" ------------------------------------------------------------------- Functions
" If buffer modified, update any 'Modified: ' in the first 20 lines.
" 'Modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    exe '1,' . n . 's#^\(.\{,10}Modified: \).*#\1' .
          \ strftime('%a %d %b %Y, %H:%M') . '#e'
    exe '1,' . n . 's#^\(.\{,10}Last Change: \).*#\1' .
          \ strftime('%a %d %b %Y, %H:%M') . '#e'
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastModified()
