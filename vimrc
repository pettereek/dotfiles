"
" .vimrc
" ------
"

set nocompatible              " be iMproved, required
filetype off                  " required

"
" Vundle
" ------
" See: https://github.com/VundleVim/Vundle.vim
"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required

Plugin 'L9'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'fatih/vim-go'
Plugin 'evidens/vim-twig'
Plugin 'digitaltoad/vim-jade'
Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'keith/swift.vim'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Javascript, React, jsx
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Colors
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

"
" Leader
" ------
"
let mapleader="," " comma is leader

"
" Editor
" ------
"
syntax on                             " Enable syntax highlighting
set encoding=utf-8                    " Use UTF-8
set number                            " Enable line numbers
set ruler                             " Show the cursor position
set hidden                            " Better handling of multiple buffers
set directory=~/.vim/swapfiles        " Swap file directory
set listchars=tab:~\.,space:\.,eol:↩︎  " Whitespace highlighting

" Tab
set tabstop=2    " Tab is 2 columns
set shiftwidth=2 " << | >> shifts 2 columns
set expandtab    " Expand tab to spaces

" Buffer search
set hlsearch   " Highlight seach results
set ignorecase " Ignore case of searches
set incsearch  " Highlight dynamically as pattern is typed
set smartcase  " Search with case if upper case is used

" Split
set splitbelow
set splitright

"
" File type handling
" ------------------
"
autocmd BufNewFile,BufRead *.hbs set filetype=html
autocmd BufNewFile,BufRead *.scss set filetype=css

"
" NerdTREE
" --------
"
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>

"
" Syntastic
" ---------
"
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_go_checkers = ['go', 'govet', 'errcheck']
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

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

" <esc> shortcuts
inoremap jk <esc>
inoremap jj <esc>

" Tab navigation with ctrl-tab, ctrl-shift-tab
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i

"
" Ag + CtrlP
" ----------
"
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor\ --skip-vcs-ignores
	let g:ag_prg = 'ag --nogroup --column --smart-case --skip-vcs-ignores --ignore-dir node_modules'
 
  " Use Ag do the searching for CtrlP
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --skip-vcs-ignores
        \ --ignore-dir node_modules --ignore-dir Godeps'
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
