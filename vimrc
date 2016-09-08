set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'flazz/vim-colorschemes'
Plugin 'fatih/vim-go'
Plugin 'evidens/vim-twig'
Plugin 'mxw/vim-jsx'
Plugin 'digitaltoad/vim-jade'
Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"
" Editor
" ------
"
syntax on                      " Enable syntax highlighting
set encoding=utf-8             " Use UTF-8
set number                     " Enable line numbers
set ruler                      " Show the cursor position
set hidden                     " Keep buffer in memory, and allow leaving them without saving
set directory=~/.vim/swapfiles " Swap file directory

" Tab
set tabstop=2    " Tab is 2 columns
set expandtab    " Expand tab to spaces
set shiftwidth=2 " << | >> shifts 2 columns

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
au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.scss set filetype=css

"
" Colors
" ------
"
colorscheme smyck

"
" NerdTREE
" --------
"
map <C-n> :NERDTreeToggle<CR>

"
" Syntastic
" ---------
"
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_go_checkers = ['go', 'govet', 'errcheck']

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
let mapleader="," " comma is leader
command! W write " Use W (capital w) for writing

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
