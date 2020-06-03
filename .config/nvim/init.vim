" Use Neovim XDG directory to load vim-plug on normal Vim
set runtimepath+=~/.local/share/nvim/site

" Plugins (vim-plug)
call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug '/usr/local/opt/fzf'           " brew install fzf
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'KabbAmine/vCoolor.vim'
Plug 'henrik/vim-indexed-search'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'alampros/vim-styled-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:vcoolor_lowercase = 1

" Settings
set hidden
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set showbreak=>\ 
" Special characters for formatting
set listchars=nbsp:⦸,tab:→\ ,eol:↵,extends:»,precedes:«,trail:·
set incsearch
set ignorecase
set smartcase
if exists('+inccommand')
  set inccommand=split      " Incremental search and replace (Neovim)
endif
set foldmethod=indent       " Fold based on indent level
set foldlevelstart=99       " Open most folds by default
set mouse=a                 " Mouse support

" Use Neovim XDG directories
set directory=~/.local/share/nvim/swap//
set undofile
set undodir=~/.local/share/nvim/undo

augroup LocalCursorline
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

augroup JumpLastPos
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

" Mappings
let mapleader = ' '
inoremap jj <Esc>
nnoremap <leader>s :let @+=@"<CR>
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Quick folding with <CR>
nnoremap <CR> za
" fzf mappings
nnoremap <leader><enter> :Buffers<CR>
nnoremap <leader>a :Rg<CR>
nnoremap <leader>t :Files<CR>
nnoremap <leader>? :Helptags<CR>
" Hide search highlights
nnoremap <leader><space> :nohlsearch<CR>
" Switch to alternate buffer
nnoremap <leader>, <C-^>
" Prettier through COC
nmap <leader>p <Plug>(coc-format)

syntax enable
colorscheme onedark
