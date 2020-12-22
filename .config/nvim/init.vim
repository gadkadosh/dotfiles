" Settings
set hidden
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set number relativenumber
" Better completion experience for completion-nvim
set completeopt=menuone,noinsert,noselect
set wildmode=longest,full
set showbreak=>\ 
set listchars=nbsp:⦸,tab:→\ ,eol:↵,extends:»,precedes:«,trail:·
set ignorecase
set smartcase
set inccommand=split
set foldmethod=indent
set foldlevelstart=99
set mouse=a
set undofile
set termguicolors
let g:vimsyn_embed="l"

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'jiangmiao/auto-pairs'
" Alternative: I might want to try https://github.com/rstacruz/vim-closer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'gadkadosh/vim-prettier', {
  \ 'branch': 'update-prettier-php',
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'php'] }
call plug#end()

" Mappings
let mapleader = ' '
inoremap jj <Esc>
nnoremap <leader>s :let @+=@"<CR>
nnoremap <leader>ev :e $MYVIMRC<CR>
" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Quick folding with <CR>
nnoremap <CR> za
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>, <C-^>

" nvim-lsp
lua << EOF
local function custom_attach()
  require'completion'.on_attach()
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})
end

require'lspconfig'.tsserver.setup{ on_attach=custom_attach }
require'lspconfig'.jsonls.setup{ on_attach=custom_attach }
require'lspconfig'.html.setup{ on_attach=custom_attach }
require'lspconfig'.cssls.setup{ on_attach=custom_attach }
require'lspconfig'.vimls.setup{ on_attach=custom_attach }
require'lspconfig'.sumneko_lua.setup({ settings = {
    Lua = { 
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
  on_attach=custom_attach })
EOF

" completion-nvim
let g:completion_confirm_key = ""
let g:completion_enable_auto_paren = 1
let g:completion_trigger_on_delete = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
      \ "\<Plug>(completion_confirm_completion)"  :
      \ "\<c-e>\<CR>" : "\<CR>"

" nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup{
  ensure_installed={ 'bash', 'lua', 'json', 'javascript', 'typescript', 'css', 'html' },
  highlight = { enable = true }, 
  indent = { enable = true }
}
EOF

" vim-prettier
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

" nvim-colorizer
lua << EOF
require'colorizer'.setup{ 'css', 'javascript', 'html' }
EOF

" FZF
nnoremap <leader><enter> :Buffers<CR>
nnoremap <leader>a :Rg<CR>
nnoremap <leader>t :Files<CR>
nnoremap <leader>? :Helptags<CR>

" Filetypes
augroup Filetypes
  autocmd!
  autocmd BufNewFile,BufRead .prettierrc setfiletype json
augroup end

syntax enable
colorscheme onedark
