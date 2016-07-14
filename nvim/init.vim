" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker :
" -----------------------------------------------------------------------------
" Filename: init.vim
" Modified: Tue 12 Jul 2016, 17:54
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details
" -----------------------------------------------------------------------------

" Plugs (Bundles) {{{
call plug#begin('~/.config/nvim/bundle')
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tomtom/tcomment_vim'
Plug 'kshenoy/vim-signature'
Plug 'qpkorr/vim-bufkill'
Plug 'godlygeek/tabular'
Plug 'aperezdc/vim-template'
Plug 'derekwyatt/vim-fswitch'
Plug 'c9s/perlomni.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'powerman/vim-plugin-AnsiEsc'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
call plug#end()
" }}}
" Formatting {{{
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
set formatoptions=rcq
                    " letter meaning when present in 'formatoptions'
                    " ------ ---------------------------------------
                    " a      Automatically format paragraphs
                    " r      Automatically insert the current comment leader
                    "        after hitting <Enter> in Insert mode.
                    " o      Automatically insert comment leader after 'o' or 'O'
                    " q      Allow formatting of comments with "gq".
                    " c      Auto-wrap comments using textwidth, inserting
                    "        the current comment leader automatically.
                    " t      Auto-wrap text using textwidth (does not apply
                    "        to comments)
                    " w      A trailing non-white space ends a paragraph.

set cino+=g0,t0,:0,N-s
" }}}
" Interface  {{{
set mouse=a
set number
set so=3
" let &t_SI = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"
:set fillchars+=vert:│
"}}}
" Statusline  {{{
" set statusline=%f%m%h%r%w%y[%l/%L,%c%V]%=[%{&fo}]%y[%{&ff}][%{&fenc==\"\"?&enc:&fenc}]
let g:airline_left_sep=''
let g:airline_right_sep=''
" let g:airline_left_sep='▌'
" let g:airline_right_sep='▐'
" let g:airline_left_alt_sep = '|'
" let g:airline_right_alt_sep = '|'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 0
let g:airline_theme='gruvbox'
" let g:airline_theme='papercolor'
"}}}
" GUI-Vim  {{{ 

set guifont=Envy\ Code\ R\ for\ Powerline\ 11
set guioptions=agi

"}}}
" Colors  {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable
set bg=dark
if has('gui_running')
   set bg=light
endif
set t_Co=256
" colorscheme PaperColor
let g:gruvbox_italic=1
colorscheme gruvbox

" Mark columns 80 and 120+
"let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(120,999),",")
set cursorline

hi link SneakPluginTarget Type
hi link SneakPluginScope Function
hi link SneakStreakTarget Type
hi link SneakStreakMask Function
"}}}
" Search / Replace {{{
set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
set showmatch
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set ignorecase      " Ignore case in search patterns.

set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

set gdefault        " Tack a 'g' on regexes, i.e., '%s/search/replace/g'

let g:sneak#streak = 1
"}}}
" Folding  {{{
set nofoldenable
autocmd Syntax c,cpp,vim,xml,html,xhtml,lua setlocal foldenable
autocmd Syntax c,cpp,vim,xml,html,xhtml,lua setlocal foldmethod     =syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,lua setlocal foldlevelstart =1

let sh_fold_enabled      =1

" let perl_fold            =0
" let perl_fold_blocks     =0
" let perl_extended_vars   =0
" let perl_sync_dist       =0

let g:xml_syntax_folding =1

autocmd FileType sh setlocal foldmarker={{{,}}} foldlevel=0 foldmethod=marker
"}}}
" Completion {{{
let g:deoplete#enable_at_startup = 1
" Define keyword
if !exists('g:deoplete#keyword_patterns')
    let g:deoplete#keyword_patterns = {}
endif

let g:deoplete#auto_completion_start_length = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = []

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"}}}
" Taglist  {{{
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File    = 1
"}}}
" Tasklist  {{{
let g:tlWindowPosition=1                      " display at bottom
let g:tlTokenList = ['TODO', 'FIXME', 'XXX']  " search tags
"}}}
" Fugitive  {{{
set diffopt+=vertical
"}}}
" netrw {{{
let g:netrw_preview = 1

augroup netrw_mapping
    autocmd filetype netrw nnoremap <buffer> q :BW<CR>
augroup END

" }}}
" Perl {{{
" automatically browse perl documentation when pressing 'K'
au FileType perl setlocal keywordprg=perldoc\ -T\ -f
" }}}
" Extern programs {{{
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*
"}}}
" Functions  {{{
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

autocmd BufWritePre * call LastModified()

" Toggle the background color between light and dark
function! ToggleBg()
   let &bg = ( &bg == "dark" ? "light" : "dark" )
endfun

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis

function! RemoveShellEscapes()
   exe '%s#\[[0-9;]*m##'
endfun

"}}}
" Keyboard mappings {{{
let mapleader=" "
"
" move by display lines instead of logical lines
nmap <silent> j gj
nmap <silent> k gk
" nnoremap <C-k> <C-w>k
" nnoremap <C-j> <C-w>j
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

nnoremap <C-s> :w!<CR>
inoremap <C-s> <Esc>:w!<CR>i
nnoremap <C-q> :q<CR>
inoremap <C-q> <Esc>:q<CR>

nmap <silent><Return> o<Esc>

" paste without copying the selected text "_ is the black hole register
vnoremap p "_dp
vnoremap P "_dP
" search for selected text with //
vnoremap // y/<C-R>"<CR>

" tag jumping
nmap ö <C-]>
nmap ä <C-t>

" goto next occurence w/o leaving search mode
cnoremap <c-n> <CR>n/<c-p>
" Previous buffer (bufkill)
nnoremap <S-Tab> :up! <bar>bp<CR>
" Next buffer (bufkill)
nnoremap <Tab> :up! <bar>bn<CR>
" clean up whitespace
nnoremap <leader>c :%s/\s\+$//<CR>:let @/=''<CR>
" Toggle background lightness
nnoremap <leader>l :call ToggleBg()<CR>
" Close window
nnoremap <leader>Q :q<CR>
" Close buffer (bufkill)
nnoremap <leader>q :BD<CR>
" Switch h / cpp (FSwitch)
nnoremap <leader>s :up <bar> FSHere<CR>
" Toggle Taglist
nnoremap <leader>T :TlistToggle<CR>
" Open Settings
nnoremap <leader>v :e ~/.config/nvim/init.vim<CR>
" open a split window and go there
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W :sp<CR> <C-w>j
" Toggle spellcheck
nnoremap <leader>z :setlocal spell! spelllang=en_us<CR>
" repair netrw
nnoremap <leader>r :set modifiable<CR> :set nu<CR>

" Use return and backspace to navigate help pages more easy
nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-T>

" use netrw
nnoremap - :e %:p:h<CR>

" }}}
" Private settings {{{
if filereadable( $HOME . "/.config/nvim/local.vim" )
   source $HOME/.config/nvim/local.vim
endif
"}}}
