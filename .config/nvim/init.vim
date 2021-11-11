" Settings
set hidden
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set scrolloff=3
" Better for autocompletion
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
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'KabbAmine/vCoolor.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mfussenegger/nvim-dap'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
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
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>p', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
      vim.cmd [[
      augroup Format
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]]
  end
end

local lspconfig = require'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = { 'clangd', 'tsserver', 'jsonls', 'html', 'cssls', 'vimls' }
for _, server in ipairs(servers) do
    lspconfig[server].setup{ 
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
EOF

" completion
lua << EOF
local cmp = require'cmp'

cmp.setup{
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-1),
        ['<C-f>'] = cmp.mapping.scroll_docs(1),
    },
    formatting = {
        format = require'lspkind'.cmp_format{
            menu = {
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                path = "[Path]",
                buffer = "[Buffer]",
            }
        }
    },
    experimental = {
        ghost_text = true
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer', keyword_length = 2 },
    },
}
EOF

" luasnip
imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>

" nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup{
  ensure_installed= "maintained",
  highlight = { enable = true },
  indent = { enable = true }
}
EOF

" nvim-dap
lua << EOF
local dap = require'dap'

vim.fn.sign_define('DapBreakpoint', { text='🛑', texthl='', linehl='', numhl='' })
vim.fn.sign_define('DapBreakpointRejected', { text='🟦', texthl='', linehl='', numhl='' })
vim.fn.sign_define('DapStopped', { text = '🟢', texthl = '', linehl = '', numhl = '' })

dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode',
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
    }
}
EOF

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>di :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <silent> <leader>ds :lua require"dap.ui.variables".scopes()<CR>

" nvim-colorizer
lua require'colorizer'.setup{ 'css', 'scss', 'javascript', 'html' }

" telescope
nnoremap <leader><enter> <cmd>Telescope buffers<CR>
nnoremap <leader>a <cmd>Telescope live_grep<CR>
nnoremap <leader>t <cmd>Telescope find_files<CR>
nnoremap <leader>f <cmd>Telescope file_browser<CR>
nnoremap <leader>? <cmd>Telescope help_tags<CR>

" Pixem
let g:pixem_use_rem = 1

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

let g:vimsyn_embed="l"
syntax enable
colorscheme tender
