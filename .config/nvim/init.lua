-- Settings
vim.opt.hidden = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.optcompleteopt = { "menuone", "noinsert", "noselect" } -- Better for autocompletion
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.showbreak = "> "
vim.opt.listchars = { nbsp = "⦸", tab = "→ ", eol = "↵", extends = "»", precedes = "«", trail = "·" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Plugins
vim.cmd([[
call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'terrortylor/nvim-comment'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'mfussenegger/nvim-dap'
Plug 'mattn/emmet-vim'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'jacoborus/tender.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-surround'
Plug '~/Code/vim-pixem'
call plug#end()
]])

-- Mappings
vim.g.mapleader = " "
vim.api.nvim_set_keymap("c", "<C-P>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-N>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>s", ':let @+=@"<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ev", ":e $MYVIMRC<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><space>", ":nohlsearch<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>,", "<C-^>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-W>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-W>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W>l", { noremap = true })

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	highlight = { enable = true },
	indent = { enable = true },
	context_commentstring = { enable = true },
})

require("nvim-autopairs").setup()
require("gitsigns").setup()
require("nvim_comment").setup({
	hook = function()
		require("ts_context_commentstring.internal").update_commentstring()
	end,
})

-- nvim-lsp
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>d",
		"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>p", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	require("lsp_signature").on_attach({ hi_parameter = "IncSearch" })

	if client.name == "tsserver" or client.name == "jsonls" or client.name == "html" or client.name == "cssls" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	if client.resolved_capabilities.document_formatting then
		vim.cmd([[
        augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
        ]])
	end
end

local null_ls = require("null-ls")
null_ls.config({
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint_d,
	},
})

null_ls.config({ sources = { null_ls.builtins.formatting.prettierd } })
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = { "clangd", "tsserver", "jsonls", "html", "cssls", "vimls", "null-ls" }
for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- completion
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		-- ["<C-k>"] = cmp.mapping.scroll_docs(-1),
		-- ["<C-j>"] = cmp.mapping.scroll_docs(1),
	},
	formatting = {
		format = require("lspkind").cmp_format({
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[NVIM]",
				luasnip = "[Snippet]",
				path = "[Path]",
				buffer = "[Buffer]",
			},
		}),
	},
	experimental = {
		ghost_text = true,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 4 },
	},
})

-- nvim-dap
local dap = require("dap")

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

dap.adapters.lldb = {
	type = "executable",
	command = "lldb-vscode",
	name = "lldb",
}

local dapCppExePath
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			if dapCppExePath ~= nil then
				print("Executing: " .. dapCppExePath)
				return dapCppExePath
			end
			dapCppExePath = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			return dapCppExePath
		end,
		cwd = "${workspaceFolder}",
	},
}

vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<S-F5>", "<cmd>lua require'dap'.terminate()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>B",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>lp",
	'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>lb", "<cmd>lua require'dap'.list_breakpoints()<CR>:copen<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>di", "<cmd>lua require'dap.ui.widgets'.hover()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>lua require'dap.ui.variables'.scopes()<CR>", { silent = true })

-- telescope
vim.api.nvim_set_keymap("n", "<leader><enter>", "<cmd>Telescope buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Telescope file_browser<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>?", "<cmd>Telescope help_tags<CR>", { noremap = true })

-- luasnip
require("luasnip/loaders/from_vscode").lazy_load()
vim.api.nvim_set_keymap(
	"i",
	"<C-j>",
	"<cmd>lua require'luasnip'.expand_or_jump()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })

-- nvim-colorizer
require("colorizer").setup({ "css", "scss", "javascript", "html" })

-- Pixem
vim.g.pixem_use_rem = 1

vim.cmd([[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])

-- vim.g.vimsyn_embed = "l"
vim.cmd("colorscheme tender")
