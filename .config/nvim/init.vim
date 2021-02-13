" Settings
set hidden
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set scrolloff=3
" Better completion experience for completion-nvim
set completeopt=menuone,noinsert,noselect
set wildmode=longest,full
set showbreak=>\ 
set listchars=nbsp:⦸,tab:→\ ,eol:↵,extends:»,precedes:«,trail:·
set ignorecase
set smartcase
set inccommand=split
set cursorline
set foldmethod=indent
set foldlevelstart=99
set mouse=a
set undofile
set termguicolors

" Use ripgrep for :grep
set grepprg=rg\ --vimgrep\ --smart-case
set grepformat=%f:%l:%c:%m

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'jacoborus/tender.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'KabbAmine/vCoolor.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/completion-nvim'
Plug 'norcalli/snippets.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'sbdchd/neoformat'
Plug '~/Code/vim-pixem'
call plug#end()

" Mappings
let mapleader = ' '
inoremap jj <Esc>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
nnoremap <leader>s :let @+=@"<CR>
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>, <C-^>

" nvim-lsp
lua << EOF
local function custom_attach()
  require'completion'.on_attach()
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})
end

local lspconfig = require'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- tsserver requires typescript to be installed, either locally or globally!
lspconfig.tsserver.setup{ on_attach = custom_attach }
lspconfig.jsonls.setup{ on_attach = custom_attach }
lspconfig.html.setup{
  filetypes = { "html", "htmldjango" },
  on_attach = custom_attach,
  capabilities = capabilities
}
lspconfig.cssls.setup{
  on_attach = custom_attach,
  capabilities = capabilities
}
lspconfig.vimls.setup{ on_attach = custom_attach }
lspconfig.pyls.setup{ on_attach = custom_attach }
EOF

" completion-nvim
let g:completion_confirm_key = ""
let g:completion_trigger_on_delete = 1
let g:completion_enable_snippet = 'snippets.nvim'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_auto_change_source = 1

imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
      \ "\<Plug>(completion_confirm_completion)"  :
      \ "\<c-e>\<CR>" : "\<CR>"

" nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup{
  ensure_installed= "maintained",
  highlight = { enable = true },
  indent = { enable = true }
}
EOF

" Neoformat
nnoremap <leader>p :Neoformat<CR>
augroup fmt
  autocmd!
  autocmd BufWritePre *.js,*.css,*.scss Neoformat
augroup end


" nvim-colorizer
lua require'colorizer'.setup{ 'css', 'scss', 'javascript', 'html' }

" FZF
" nnoremap <leader><enter> :Buffers<CR>
" nnoremap <leader>a :Rg<CR>
" nnoremap <leader>t :Files<CR>
" nnoremap <leader>? :Helptags<CR>
nnoremap <leader><enter> <cmd>Telescope buffers<CR>
nnoremap <leader>a <cmd>Telescope live_grep<CR>
nnoremap <leader>t <cmd>Telescope find_files<CR>
nnoremap <leader>? <cmd>Telescope help_tags<CR>

" Pixem
let g:pixem_use_rem = 1

" snippets.nvim
lua << EOF
local snips = require'snips'
require'snippets'.snippets = {
  _global = snips._global,
  javascript = snips.javascript,
  typescript = snips.javascript,
  html = snips.html,
  htmldjango = snips.html,
  css = snips.css,
  scss = snips.css,
}
require'snippets'.set_ux(require'snippets.inserters.text_markers')
EOF
inoremap <c-j> <cmd>lua return require'snippets'.expand_or_advance()<CR>
inoremap <c-k> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

let g:vimsyn_embed="l"
syntax enable
colorscheme tender
