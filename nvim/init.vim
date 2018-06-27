" -----------------------------------------------------------------------------
" Filename: init.vim
" Modified: Fri 08 Jun 2018, 08:39
" See:      http://vimdoc.sourceforge.net/htmldoc/options.html for details
" -----------------------------------------------------------------------------
" reload this file when saving
autocmd! bufwritepost init.vim 
   \ source % |
   \ call LightlineReload()

" let g:loaded_python_provider = 1
" let g:python_host_prog="/home/blp4hi/.neovim_python/bin/python"
let g:python3_host_prog="/home/blp4hi/.neovim_python/bin/python"

" Plugs (Bundles) {{{1
call plug#begin('~/.config/nvim/bundle')
Plug 'tpope/vim-surround'                 " quoting / parenthesizing
Plug 'tpope/vim-repeat'                   " add . support to other plugs
Plug 'tpope/vim-fugitive'                 " git support
Plug 'itchyny/lightline.vim'              " status bar
Plug 'NLKNguyen/papercolor-theme'         " color theme
Plug 'morhetz/gruvbox'         " color theme
Plug 'christoomey/vim-tmux-navigator'     " switch between panes
Plug 'tomtom/tcomment_vim'                " easy un/commenting
Plug 'kshenoy/vim-signature'              " display / navigate marks
Plug 'qpkorr/vim-bufkill'                 " kill buffer without closing window
Plug 'godlygeek/tabular'                  " align columns
Plug 'ludovicchabant/vim-gutentags'       " automatically create tag files
Plug 'vim-scripts/taglist.vim'            " list of functions / variables
Plug 'aperezdc/vim-template'              " templates for file types
Plug 'derekwyatt/vim-fswitch'             " switch C header/implementation
Plug 'powerman/vim-plugin-AnsiEsc'        " display shell escapes
Plug 'jlanzarotta/bufexplorer'            " list buffers
Plug 'Shougo/neosnippet.vim'              " snippets from Shougo
Plug 'Shougo/neosnippet-snippets'         " snippet data from Shougo
Plug 'honza/vim-snippets'                 " snippet data
" Plug 'xolox/vim-misc'                     " requirement of vim-session
" Plug 'xolox/vim-session'                  " save and load sessions
Plug 'mileszs/ack.vim'                    " ack support
Plug 'stefandtw/quickfix-reflector.vim'   " edit directly in the qf window
" Plug 'vim-syntastic/syntastic'            " syntax checker
" Plug 'joonty/vdebug'                      " Debugger integration
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
call plug#end()

" Folding  {{{1
syntax enable
set nofoldenable
let g:xml_syntax_folding =1
let g:sh_fold_enabled =1
autocmd Syntax c,cpp,vim,xml,html,xhtml,lua setlocal foldenable
autocmd Syntax c,cpp,vim,xml,html,xhtml,lua setlocal foldmethod     =syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,lua setlocal foldlevelstart =1
autocmd FileType sh setlocal foldenable "foldmarker={{{,}}} foldlevel=0 foldmethod=marker

function! GetPerlFold()
   if getline(v:lnum) =~ '^\s*sub\s'
      return ">1"
   elseif getline(v:lnum) =~ '\}\s*$'
      let my_perlnum = v:lnum
      let my_perlmax = line("$")
      while (1)
         let my_perlnum = my_perlnum + 1
         if my_perlnum > my_perlmax
            return "<1"
         endif
         let my_perldata = getline(my_perlnum)
         if my_perldata =~ '^\s*\(\#.*\)\?$'
            " do " nothing
         elseif my_perldata =~ '^\s*sub\s'
            return "<1"
         else
            return "="
         endif
      endwhile
   else
      return "="
   endif
endfunction
autocmd FileType perl setlocal foldexpr=GetPerlFold()
autocmd FileType perl setlocal foldmethod=expr

" Formatting {{{1
" based on filetype
filetype plugin indent on
" indent xml with special command
au FileType xml setlocal equalprg=xmlindent\ -i3\ -l78

set nowrap
set tabstop     =3
set shiftwidth  =3
set softtabstop =0
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
set autoindent      " Copy indent from current line when starting a new line
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
" Colors  {{{1
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256
set bg=dark
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'allow_bold': 1,
  \       'allow_italic': 1
  \     }
  \   }
  \ }
colorscheme PaperColor

" Interface  {{{1
set mouse=a
set number
set so=3
set visualbell
" let &t_SI = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"
:set fillchars+=vert:│
let g:lightline = {
   \ 'active': {
   \     'left': [ [ 'mode' ],
   \               [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
   \ },
   \ 'component': {
   \     'fugitive': '%{exists("*fugitive#statusline")?fugitive#statusline():""}'
   \ },
   \ 'component_visible_condition': {
   \     'fugitive': '(exists("*fugitive#statusline") && ""!=fugitive#statusline())'
   \ }
   \ }

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" Clipboard {{{1
" always yank directly to system clipboard
set clipboard=unnamed

" Directory {{{1
" set autochdir
" autocmd BufEnter * silent! lcd %:p:h

" Mark columns 80 and 120+
"let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(120,999),",")
set cursorline

" Search / Replace {{{1
set hlsearch        " Highlight prevoius search pattern
set showmatch
set incsearch       " Highlight while typing search
set ignorecase      " Ignore case in search patterns.
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
set gdefault        " Tack a 'g' on regexes, i.e., '%s/search/replace/g'
augroup auto_quickfix_open
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
         \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
         \gvy/<C-R><C-R>=substitute(
         \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
         \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
         \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
         \gvy?<C-R><C-R>=substitute(
         \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
         \gV:call setreg('"', old_reg, old_regtype)<CR>

" Completion {{{1
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 3
" In a completion list, <tab> goes to the next item, 
" <shift><tab> goes to the last item.
" In a snippet context, <tab> jumps to the next mark.
inoremap <silent><expr><S-TAB>
   \ pumvisible() ? "\<C-p>" : "\<TAB>"
imap <silent><expr><TAB>
   \ pumvisible() ? "\<C-n>" :
   \ neosnippet#expandable_or_jumpable() ?
   \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <silent><expr><TAB> 
    \ neosnippet#expandable_or_jumpable() ? 
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <silent><expr><CR>
   \ pumvisible() ? 
   \ deoplete#mappings#close_popup()."\<Plug>(neosnippet_expand_or_jump)"
   \ : "\<CR>"

" Taglist  {{{1
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File    = 1
autocmd BufWritePost *.cpp :TlistUpdate
autocmd BufWritePost *.c :TlistUpdate
autocmd BufWritePost *.h :TlistUpdate

" Tasklist  {{{1
let g:tlWindowPosition=1                      " display at bottom
let g:tlTokenList = ['TODO', 'FIXME', 'XXX']  " search tags

" Templates {{{1
let g:templates_directory = [ '~/.config/nvim/templates' ]

" Fugitive  {{{1
set diffopt+=vertical

" Diff {{{1
set diffopt+=iwhite
" }}}
" Sessions {{{1
let g:session_autoload=0
let g:session_directory="~/.config/nvim/sessions"
" }}}
" netrw {{{1
let g:netrw_preview   = 1
let g:netrw_liststyle = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_hide      = 1

augroup netrw_mapping
    autocmd filetype netrw nnoremap <buffer> <ESC> :bd<CR>
augroup END
" }}}
" Perl {{{1
" automatically browse perl documentation when pressing 'K'
au FileType perl setlocal keywordprg=perldoc\ -T\ -f
" Perl Debugging {{{1
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
let g:vdebug_options["break_on_open"] = 0


" Syntax check {{{1
" let g:syntastic_enable_perl_checker = 1
" let g:syntastic_perl_checkers=['perl']
" let g:syntastic_enable_balloons = 1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height=5
" let g:syntastic_auto_loc_list=1
" let g:syntastic_enable_signs=1
" let g:syntastic_error_symbol="E→"
" let g:syntastic_warning_symbol="W→"

" Functions  {{{1
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
   call LightlineReload()
endfun

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis

function! RemoveShellEscapes()
   exe '%s#\[[0-9;]*m##'
endfun

" Easily GREP current word in current file.
command! GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc

" Keyboard mappings {{{1
let mapleader=" "
"
" move by display lines instead of logical lines
nmap <silent> j gj
nmap <silent> k gk
" nnoremap <C-k> <C-w>k
" nnoremap <C-j> <C-w>j
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

" disable search highlight
nnoremap <silent> <esc> :noh<cr><esc>

nnoremap <C-s> :w!<CR>
inoremap <C-s> <Esc>:w!<CR>i
nnoremap <C-q> :q<CR>
inoremap <C-q> <Esc>:q<CR>

" paste without copying the selected text "_ is the black hole register
vnoremap p "_dp
vnoremap P "_dP
" search for selected text with //
vnoremap // y/<C-R>"<CR>

" tag jumping
nmap ö <C-e>
nmap Ö <C-d>
nmap ä <C-y>
nmap Ä <C-u>

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
nnoremap <leader>y :let @* = expand("%:p")<CR>

" Use return and backspace to navigate help pages more easy
nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-T>

" use netrw
nnoremap - :e %:p:h<CR>
" }}}
" Private settings {{{1
if filereadable( $HOME . "/.config/nvim/local.vim" )
   source $HOME/.config/nvim/local.vim
endif
" vim: set foldmethod=marker :
