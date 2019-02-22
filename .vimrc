" vim-plug and plugin settings

" Use Neovim XDG directory to load vim-plug on normal Vim
if !has('nvim')
  set runtimepath+=~/.local/share/nvim/site
endif

" Download vim-plug if it's not installed already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup VimPlug
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

" Start vim-plug and list plugins
call plug#begin('~/.local/share/nvim/plugged')

" Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim'

" Utilities
Plug '/usr/local/opt/fzf'           " fzf is installed locally through brew
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-eunuch'
Plug 'KabbAmine/vCoolor.vim'        " Color picker
Plug 'henrik/vim-indexed-search'    " Shows how many matches were found
Plug 'gregsexton/matchtag'          " Highlight matching HTML tags
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'alampros/vim-styled-jsx'

" Completion
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'         " Auto-close parentheses, brackets etc..

call plug#end()
" End vim-plug listing

" Prettier settings
let g:prettier#exec_cmd_async = 1   " Run prettier asynchronously
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {}
" javascript: npm -g install javascript-typescript-langserver
if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands['javascript'] = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands['typescript'] = ['javascript-typescript-stdio']
endif
" html: npm -g install vscode-html-languageserver-bin
if executable('html-languageserver')
  let g:LanguageClient_serverCommands['html'] = ['html-languageserver', '--stdio']
endif
" css: npm -g install vscode-css-languageserver-bin
if executable('css-languageserver')
  let g:LanguageClient_serverCommands['css'] = ['css-languageserver', '--stdio']
endif
" python: pip install python-language-server
if executable('pyls')
  let g:LanguageClient_serverCommands['python'] = ['pyls']
endif

let g:deoplete#enable_at_startup = 1

imap <expr> <C-j> pumvisible() ? "\<Down>" : "\<C-j>"
imap <expr> <C-k> pumvisible() ? "\<Up>" : "\<C-k>"

let g:vcoolor_lowercase = 1

" set emmet for jsx syntax
let g:user_emmet_settings = { 'javascript.jsx': { 'extends': 'jsx' } }

" Close NERDTree automatically when opening a file
let g:NERDTreeQuitOnOpen = 1

" Colors
colorscheme onedark

" Customize color schemes
augroup colorscheme_customization
  autocmd!
  " OneDark - Transparent background
  autocmd ColorScheme onedark highlight Normal ctermbg=NONE
augroup END

syntax enable

" Indentation
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
set autoindent smartindent

set showbreak=¬\            " Symbol for showing wrapped lines
" Special characters for formatting enable
set listchars=nbsp:⦸,tab:→\ ,eol:↵,extends:»,precedes:«,trail:·

" Settings
set hidden                  " Allow hidden Buffers
set number relativenumber   " Show line numbers (relative)
set backspace=indent,eol,start
set cursorline              " Highlight current line, see next few line

if has('nvim')
  augroup Terminal
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
  augroup END
endif

" Show cursorline for current window only
augroup Cursorline
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

set mouse=a                 " Mouse support
if !has('nvim')
  set ttymouse=sgr          " Fast modern mouse dragging
endif

set wildmenu wildmode=longest:full,full  " Visual autocompletion for command line
set lazyredraw              " No redraw in the middle of macros (performance)
set scrolloff=3             " Start scrolling before reaching the first or last lines
set splitbelow splitright   " Create splits below and to the right

" Jump to last cursor position on file load
augroup JumpPos
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

" Status line
set laststatus=2                " Always show status line
set statusline=\ ☲\ 
set statusline+=%{fugitive#head()!=''?'\ ['.fugitive#head().']':''}\ 
set statusline+=%<%f\ %m%r%=%y\ \ %2l:%2c\ ◼\ %P\ 

" Search
set incsearch               " Search as characters are being typed
set ignorecase smartcase    " Case insensitive search
if exists('+inccommand')
  set inccommand=split    " Incremental search and replace (Neovim)
endif

" Folding
if has('folding')
  set fillchars+=fold:·       " Unicode middle dot instead of dashes
  set foldlevelstart=99       " Open most folds by default
  set foldmethod=indent       " Fold based on indent level
  set foldtext=CustomFoldtext()

  function! CustomFoldtext()
    let middot = '·'
    let raquo = '» '
    let lines = ' [' . (v:foldend - v:foldstart + 1) . ' lines' . '] '
    let first = ' ' . substitute(getline(v:foldstart), '\v *', '', '')
    let dashes = substitute(v:folddashes, '-', middot, 'g')
    return raquo . middot . middot . lines . dashes . first . ' '
  endfunction
endif

" Mappings
let mapleader = " "
inoremap jj <Esc>
nnoremap <leader>s :let @+=@"<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map tab when completion is open
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" Quick folding with <CR>
nnoremap <CR> za

" fzf mappings
nnoremap <leader><enter> :Buffers<CR>
nnoremap <leader>a :Rg<CR>
nnoremap <leader>c :Colors<CR>
nnoremap <leader>t :Files<CR>
nnoremap <leader>/ :History/<CR>
nnoremap <leader>: :History:<CR>
nnoremap <leader>? :Helptags<CR>

nnoremap <leader>f :NERDTreeToggle<CR>

" Hide search highlights
nnoremap <leader><space> :nohlsearch<CR>

" Switch to alternate buffer
nnoremap <leader>, <C-^>

" Leader mappings for LanguageClient
nnoremap <leader>h :call LanguageClient#textDocument_hover()<CR>

" Swapfiles
if exists('$SUDO_USER')
  set noswapfile                    " Don't create root-owned files
elseif !has('nvim')                 " Use Neovim XDG directory
  set directory=~/.local/share/nvim/swap// " Keeps swap files out of the way
endif

" Persistent undo
if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                  " Don't create root-owned files
  else
    set undofile
  endif

  if !has('nvim')                   " Use Neovim XDG directory
    set undodir=~/.local/share/nvim/undo " Keep undo files out of the way
  endif
endif