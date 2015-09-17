" GENERAL CONFIGURATION {{{

" be iMproved, required
set nocompatible                

" changement de la touche "leader"
let mapleader = ","

" Rechargement du VIMRC après une modif
autocmd! BufWritePost .vimrc source % | setlocal foldmethod=marker
" }}}

" PATHOGEN {{{
" (chargement des plugins dans bundle) 

" chargement du fichier pathogen
source ~/.vim/vim-pathogen/autoload/pathogen.vim

" chargement des plugins
execute pathogen#infect()       

" }}}

" ENCODAGE {{{

" encodage dans vim
set encoding=utf-8

" encodage des fichiers
set fileencoding=utf-8

" }}}

" INDENTATION {{{
set tabstop=4 
set softtabstop=0 
set expandtab 
set shiftwidth=4 
set smarttab
set autoindent
set smartindent

" }}}

" INTERFACE {{{

set number
set relativenumber
set scrolloff=7
set wildmenu
set laststatus=2
syntax on
set background=light
set t_Co=256
colorscheme peaksea
hi FoldColumn ctermbg=grey ctermfg=white cterm=NONE
hi FoldColumn ctermbg=grey ctermfg=white
hi FoldColumn guifg=white guibg=grey
hi FoldColumn guifg=white guibg=grey gui=NONE
if has('gui_running')
    set guifont=Source\ Code\ Pro
    set lines=300 columns=300
endif

" }}}

" FICHIERS {{{
set autoread
set nobackup
set nowb
set noswapfile

set autochdir
" }}}

" GESTION DES SAUTS DE LIGNE {{{

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" }}}

" RECHERCHE {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw 
set magic
set showmatch
set mat=2
nnoremap / /\v
nnoremap ? ?\v

" }}}

" FOLDING {{{

set foldcolumn=4
set foldenable 
set foldlevelstart=0
set foldnestmax=10
" space open/closes folds
nnoremap <space> za
set foldmethod=syntax
augroup vim_foldmethod 
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker | inoremap {{{ {{{<cr><cr> " }}}<esc><<kA
    "}}}
augroup END

" }}}

" NERDTree {{{  
" ,n => Toggle NERDTree
    nnoremap <leader>n :NERDTreeToggle<cr>
    let NERDTreeDirArrows = 0

" }}}

" CtrlP {{{
    " ,p => CtrlP
    let g:ctrlp_map = '<leader>p'
    let g:ctrlp_working_path_mode='rw'
" }}}

" TagList {{{
    " ,t => Toggle TagList
    nnoremap <leader>t :TlistToggle<cr>
    let Tlist_WinWidth=70
    let Tlist_Use_Right_Window=1
" }}}

" Expand Region {{{
" ,e => expand selection
" ,r => shrink (retract) selection
map <leader>e <Plug>(expand_region_expand)
map <leader>r <Plug>(expand_region_shrink)
" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" SVNJ {{{ 
    let g:svnj_cache_dir="C:\\Users\\A52302\\Downloads"
" }}}

" MAPPINGS  {{{

" copy / paste
set clipboard=unnamed

"In insert mode, helpers for brackets and quotes
inoremap '' ''<esc>i
inoremap "" ""<esc>i
inoremap (( ()<esc>i
inoremap {{ {<cr><cr>}<esc>ki<tab>
inoremap [[ [<cr><cr>]<esc>ki<tab>

" ,, => In insert mode, remap for <esc>
inoremap <leader><leader> <esc>

" tab => autocomplete
function! Smart_TabComplete()
    let line = getline('.')                         " current line

    let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
    let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return "\<tab>"
    endif
    let has_period = match(substr, '\.') != -1      " position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any
    if (!has_period && !has_slash)
        return "\<C-X>\<C-P>"                         " existing text matching
    elseif ( has_slash )
        return "\<C-X>\<C-F>"                         " file matching
    else
        return "\<C-X>\<C-O>"                         " plugin matching
    endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

map j gj
map k gk

" ,, => clear search
map <silent> <leader><leader> :nohlsearch<cr>

" navigation entre splits : ctrl + fleches
nnoremap [A <c-w><c-k> 
nnoremap <C-Up> <c-w><c-k> 
nnoremap [B <c-w><c-j>
nnoremap <C-Down> <c-w><c-j>
nnoremap [D <c-w><c-h>
nnoremap <C-Left> <c-w><c-h>
nnoremap [C <c-w><c-l>
nnoremap <C-Right> <c-w><c-l>

" ,fleches => ajoute une ligne au dessus ou en dessous de la ligne
nnoremap <c-k> O<esc>j
nnoremap <c-j> o<esc>k

inoremap <c-k> <esc>O
inoremap <c-j> <esc>o

inoremap XX <esc>:w<cr>:bd<cr>
inoremap QQ <esc>:bd<cr>
inoremap WW <esc>:w<cr>

nnoremap XX :w<cr>:bd<cr>
nnoremap QQ :bd<cr>
nnoremap WW :w<cr>
nnoremap %% ggVG


autocmd FileType cs inoremap /// /// <summary><cr><cr></summary><esc>kA 

" }}}

" OMNISHARP {{{
" OmniSharp won't work without this setting
filetype plugin on

let g:Omnisharp_start_server = 0

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
"let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
"set noshowmatch

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
    autocmd FileType cs setlocal foldmethod=syntax

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    "autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    " autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    " autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    " autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    " autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    " autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    " autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    " autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    " autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    " autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    " autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    " autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    " autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

    autocmd FileType cs nnoremap <F12> :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <S-F12> :OmniSharpFindUsages<cr>
augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden
 " }}}
command! CDRCF :cd ~\Desktop\RCF\ | let g:net_framework_version="3.5"

" DBEXT {{{
let g:dbext_default_profile_ASE = 'type=ASE:user=CFadmin:passwd=@askg:srvname=SRV_COVEAFI_DEV:dbname=COVEAFI_DEV'
let g:dbext_default_profile = 'ASE'
 " }}}
