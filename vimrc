" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"
" .vimrc
" ------
"
set nocompatible " be iMproved, required

call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Language support
Plug 'fatih/vim-go'

" Colors
Plug 'arcticicestudio/nord-vim'

call plug#end()

"
" Leader
" ------
"
let mapleader="," " comma is leader

"
" Editor
" ------
"
syntax on                      " Enable syntax highlighting
set encoding=utf-8             " Use UTF-8
set number                     " Enable line numbers
set ruler                      " Show the cursor position
set hidden                     " Better handling of multiple buffers
set cursorline
set directory=~/.vim/swapfiles " Swap file directory
set list lcs=trail:·,tab:»·    " Whitespace highlighting
set list
set mouse=a                    " Clicking, scrolling, selecting etc.

" Tab
set tabstop=2    " Tab is 2 columns
set shiftwidth=2 " << | >> shifts 2 columns
set expandtab    " Expand tab to spaces

" Buffer search
set hlsearch   " Highlight seach results
set ignorecase " Ignore case of searches
set smartcase  " Search with case if upper case is used
set incsearch  " Highlight dynamically as pattern is typed

" Split
set splitbelow
set splitright

"
" Colors & Theme settings
" -----------------------
"
if (has("termguicolors"))
  set termguicolors " enable 'True color'
endif

set background=dark
colorscheme nord

" Nord specifics
let g:nord_italic = 1               " Enable italic style
let g:nord_italic_comments = 1      " Italic comments
let g:nord_uniform_status_lines = 1

"
" File type handling
" ------------------
"
autocmd BufNewFile,BufRead *.hbs set filetype=html
autocmd BufNewFile,BufRead *.scss set filetype=scss

"
" NerdTREE
" --------
"
let NERDTreeSortHiddenFirst=1
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
map <leader>fs :NERDTreeToggle<CR>
map <leader>ff :NERDTreeFind<CR>

"
" Syntastic
" ---------
"
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers = ['mixedindentlint', 'eslint']
let g:syntastic_go_checkers = ['go', 'govet', 'errcheck']
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
let g:syntastic_css_checkers = ['mixedindentlint']
let g:syntastic_scss_checkers = ['mixedindentlint']

"
" Jsx
" ---
"
let g:jsx_ext_required = 0 " allow .js files (instead of just jsx)

"
" ViM go
" ------
"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

"
" Keyboard
" --------
"
command! W w
command! Q q
command! Wq wq
command! WQ wq
command! Vs vs

" <esc> shortcuts
inoremap jk <esc>
inoremap jK <esc>
inoremap Jk <esc>
inoremap JK <esc>
inoremap jj <esc>
inoremap jJ <esc>
inoremap Jj <esc>
inoremap JJ <esc>

"
" Ag + CtrlP
" ----------
"
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor\ --skip-vcs-ignores
	let g:ag_prg = 'ag --nogroup --column --smart-case --skip-vcs-ignores --ignore-dir node_modules'

  " Use Ag search for CtrlP
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""
        \ --ignore-dir node_modules
        \ --ignore-dir Godeps
        \ --ignore-dir deps
        \ --ignore-dir _deploy
        \ --ignore-dir _build
        \ --skip-vcs-ignores'
	let g:ctrlp_use_caching = 0
endif

nmap <leader>a :Agext <C-r>=expand('%:e')<CR>
nmap <leader>A :Ag <C-r><CR>
command! -nargs=+ Agext call AgExt(<q-args>)

" Limit Ag command search to a specific file type
function! AgExt(...) "{{{
	let words = split(a:1)
	let ext = words[0]
	let rest = join(words[1:-1], ' ')
	echo "normal :Ag -G '\.(".ext.")$' ".rest."<CR>"
	exe "Ag -G '\.(".ext.")$' ".rest
endfunction "}}}

"
" YouCompleteMe
" -------------
"
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

"
" UltiSnips
" ---------
"
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<C-m>'
let g:UltiSnipsJumpBackwardTrigger='<C-n>'
let g:UltiSnipsSnippetsDir='~/.vim/customsnips'
let g:UltiSnipsSnippetDirectories=['customsnips', 'UltiSnips']
