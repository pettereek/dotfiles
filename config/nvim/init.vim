" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'neomake/neomake'

" Search
Plug 'ctrlpvim/ctrlp.vim'

" Completion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Language support
Plug 'fatih/vim-go'
Plug 'elixir-editors/vim-elixir'
"Plug 'slashmili/alchemist.vim'

" JS, TS
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Plug 'HerringtonDarkholme/yats.vim'

Plug 'sainnhe/vim-color-forest-night'

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
set updatetime=250             " Be snappy

" Tab
set tabstop=2    " Tab is 2 columns
set shiftwidth=2 " << | >> shifts 2 columns
set expandtab    " Expand tab to spaces

" Buffer search
set hlsearch   " Highlight seach results
set ignorecase " Ignore case of searches
set smartcase  " Search with case if upper case is used
set incsearch  " Highlight dynamically as pattern is typed

"
" Colors & Theme settings
" -----------------------
"
if (has("termguicolors"))
  set termguicolors " enable 'True color'
endif

set background=dark
colorscheme forest-night

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
" When reading a buffer (after 1s), and when writing (no delay).
" https://github.com/neomake/neomake#setup
"call neomake#configure#automake('rw', 1000)
"let g:neomake_error_sign = { 'text': 'E-', 'texthl': 'ErrorMsg' }
"let g:neomake_warning_sign = { 'text': 'W-', 'texthl': 'NeomakeWarningSign' }

"
" Golang
" ------
"
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_fields = 1

imap ierr <esc>:GoIfErr<CR><S-o>
map ierr :GoIfErr<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

"
" Copy/Paste
" ----------
"
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

"
" Search
" ------
"
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --skip-vcs-ignores
  let g:ag_prg = 'ag --vimgrep --smart-case --skip-vcs-ignores --ignore-dir node_modules'

  " Use Ag search for CtrlP
  let g:ctrlp_user_command = '
        \ ag %s
        \ --files-with-matches --nocolor --filename-pattern
        \ ""
        \ --skip-vcs-ignores
        \ --ignore-dir node_modules
        \ --ignore-dir vendor
        \ --ignore-dir deps
        \ --ignore-dir _deploy
        \ --ignore-dir _build
        \ '

  " Ag is fast enough to skip cache
  let g:ctrlp_use_caching = 0
endif

"command -nargs=+ -complete=file -bar Search silent! grep! <args>|cwindow|redraw!
"nnoremap <leader>s :Search<SPACE>
"nnoremap <leader>S :Search<SPACE>-G'\.<C-r>=expand('%:e')<CR>$'<SPACE>
"nnoremap <leader>ds :Search<SPACE><C-r>=expand('%:p:h')<CR><SPACE>
"nnoremap <leader>ws :Search<SPACE><C-R><C-W><CR>

"
" coc.nvim
" --------
"
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Set correct filetype for javascript for coc-vim to work with React/jsx
" See note: https://github.com/neoclide/coc-tsserver
autocmd BufNewFile,BufRead *.js set filetype=javascript.jsx
