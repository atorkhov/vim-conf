" Ctrl-O - jump older position in jump list

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Tagbar'
Plugin 'bufexplorer.zip'
Plugin 'cmake.vim'
Plugin 'spec.vim'
Plugin 'python.vim'
Plugin 'Python-Syntax-Folding'
Plugin 'Python-Syntax'
Plugin 'ruby.vim'
Plugin 'rails.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'EasyGrep'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
" Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic' " syntax checking
Plugin 'bling/vim-airline'
Plugin 'jnwhiteh/vim-golang'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'airblade/vim-gitgutter'
Plugin 'w0ng/vim-hybrid'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on

syntax enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
set smartindent
"set nocompatible
set backspace=indent,eol,start
set backupcopy=auto,breakhardlink
"filetype on
"filetype plugin on
set list
set listchars=tab:▸\ ,nbsp:⋅,trail:•
set fencs=ucs-bom,utf-8,cp1251

"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#CompleteCpp

autocmd FileType javascript set ts=2 sw=2 sts=2
autocmd FileType css,scss set ts=2 sw=2 sts=2
autocmd FileType html set ts=2 sw=2 sts=2
autocmd FileType ruby,haml set ts=2 sw=2 sts=2

au Bufread,BufNewFile *.md set filetype=markdown

autocmd FileType markdown set textwidth=79

let g:explHideFiles='^\.'
let g:explDetailedList=1
let g:autoclose_on=0

set hidden

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
" set tags+=~/.vim/tags/gl
" set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4

" build tags of your own project with Ctrl-F12

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" tags update
if has ("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        map <C-F12> :!/usr/local/bin/ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
        au BufWritePost *.c,*.cpp,*.h silent! !/usr/local/bin/ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q . &
    else
        map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
        au BufWritePost *.c,*.cpp,*.h silent! !ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q . &

        vnoremap <m-x> "+x
        vnoremap <S-Del> "+x
        " CTRL-C and CTRL-Insert are Copy
        vnoremap <m-c> "+y
        vnoremap <C-Insert> "+y

        " CTRL-V and SHIFT-Insert are Paste
        map <m-v>       "+gP
        map <S-Insert>  "+gP

        cmap <m-v>      <C-R>+
        cmap <S-Insert> <C-R>+

        " Pasting blockwise and linewise selections is not possible in Insert and
        " Visual mode without the +virtualedit feature.  They are pasted as if they
        " were characterwise instead.
        " Uses the paste.vim autoload script.

        exe 'inoremap <script> <m-v>' paste#paste_cmd['i']
        exe 'vnoremap <script> <m-v>' paste#paste_cmd['v']
        imap <S-Insert>     <m-v>
        vmap <S-Insert>     <m-v>

        " my old binds
        " nmap <m-v> "+gp
        " imap <m-v> <ESC><m-v>A
        " vmap <m-c> "+y
        " vmap <m-x> "+x
    endif
endif

" keys
if has ("gui_running")
    set nu
    set foldcolumn=1

	set toolbariconsize=tiny
    if has ("gui_gtk2")
        "set guifont=Monaco\ 10
        "set guifont=Inconsolata
        set guifont=Terminus
        behave mswin
    endif
    if has("gui_macvim")
        let macvim_hig_shift_movement = 1
        set guifont=Monaco:h12
    endif
    if has("gui_win32")
    else
    endif
endif

" Stop highlighting
nnoremap <leader><space> :noh<cr>

" color and theme
set t_Co=256
"colorscheme desert
colorscheme hybrid

" Project support
"map <silent> <c-p> <Plug>ToggleProject
map <C-p> :NERDTreeToggle<CR>
if has("gui_running")
    autocmd vimenter * NERDTree
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$']
let g:bufExplorerDefaultHelp=0
let g:bufExplorerSplitHorzSize=10

let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

let g:ctrlp_map = '<leader>p'

" Tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>

" Folding & numbering
set foldmethod=syntax
set foldlevel=3

if has("gui_running")
    set foldcolumn=1
    set number
endif

" SPEC
au BufNewFile *.spec set expandtab | set ts=8 | retab | set ts=4
let spec_chglog_prepend = 1
" au FileType spec map <buffer> <F5> <Plug>AddChangelogEntry
" use \-c to add changelog entry
let spec_chglog_packager = 'Alexey Torkhov <atorkhov@gmail.com>'

" No hotkeys for menu
set winaltkeys=no

" Some bindings
nnoremap <silent> <m-t> :tabnew<CR>
nnoremap <silent> <m-w> :tabclose<CR>
nnoremap <silent> <m-]> :tabnext<CR>
nnoremap <silent> <m-[> :tabprevious<CR>
nnoremap <silent> <m-1> 1gt
nnoremap <silent> <m-2> 2gt
nnoremap <silent> <m-3> 3gt
nnoremap <silent> <m-4> 4gt
nnoremap <silent> <m-5> 5gt
nnoremap <silent> <m-6> 6gt
nnoremap <silent> <m-7> 7gt
nnoremap <silent> <m-8> 8gt
nnoremap <silent> <m-9> 9gt
nnoremap <silent> <m-0> 10gt

nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary

nmap [h <Plug>GitGutterPrevHunk
nmap ]h <Plug>GitGutterNextHunk

set pastetoggle=<F8>

nnoremap <Esc>[1;5D b
nnoremap <Esc>[1;5C w

" Development

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Syntax checking
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_scss_checkers = ['scss_lint']

nnoremap <leader>rs :!clear;bundle exec rake<CR>
