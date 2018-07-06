" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Language support
Plug 'fatih/vim-go'

" Syntax
Plug 'neomake/neomake'

" Initialize plugin system
call plug#end()

"
" Leader
" ------
"
let mapleader="," " comma is leader

"
" Deoplete
" --------
"
let g:deoplete#enable_at_startup = 1

"
" Editor
" ------
"
syntax on                      " Enable syntax highlighting
set encoding=utf-8             " Use UTF-8
set number                     " Enable line numbers
set ruler                      " Show the cursor position
set hidden                     " Better handling of multiple buffers
set directory=~/.vim/swapfiles " Swap file directory
set list lcs=trail:·,tab:»·    " Whitespace highlighting
set list
set mouse=a                    " Clicking, scrolling, selecting etc.

" Tab
set tabstop=2    " Tab is 2 columns
set shiftwidth=2 " << | >> shifts 2 columns
set expandtab    " Expand tab to spaces

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
" NERDTree
" --------
"
map <leader>fs :NERDTreeToggle<CR>
map <leader>ff :NERDTreeFind<CR>

"
" Neomake
" -------
"
call neomake#configure#automake('rw', 1000) " When reading a buffer (after 1s), and when writing (no delay).
let g:neomake_error_sign = { 'text': 'E-', 'texthl': 'ErrorMsg' }
let g:neomake_warning_sign = { 'text': 'W-', 'texthl': 'NeomakeWarningSign' }

"
" Golang
" ------
"
let g:go_fmt_command = "goimports"


"
" Ag + CtrlP
" ----------
"
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor\ --skip-vcs-ignores
	let g:ag_prg = 'ag --nogroup --column --smart-case --skip-vcs-ignores --ignore-dir node_modules'

  " Use Ag search for CtrlP
  let g:ctrlp_user_command = '
        \ ag %s
        \ --files-with-matches --nocolor --filename-pattern
        \ ""
        \ --skip-vcs-ignores
        \ --ignore-dir node_modules
        \ --ignore-dir Godeps
        \ --ignore-dir vendor
        \ --ignore-dir deps
        \ --ignore-dir _deploy
        \ --ignore-dir _build
        \ '

  " Ag is fast enough to skip cache
	let g:ctrlp_use_caching = 0
endif

" nmap <leader>a :Agext <C-r>=expand('%:e')<CR>
" nmap <leader>A :Ag <C-r><CR>
" command! -nargs=+ Agext call AgExt(<q-args>)

" Limit Ag command search to a specific file type
" function! AgExt(...) "{{{
" 	let words = split(a:1)
" 	let ext = words[0]
" 	let rest = join(words[1:-1], ' ')
" 	echo "normal :Ag -G '\.(".ext.")$' ".rest."<CR>"
" 	exe "Ag -G '\.(".ext.")$' ".rest
" endfunction "}}}
