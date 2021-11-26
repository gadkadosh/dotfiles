-- Faster startup (caching lua modules)
pcall(require, "impatient")

-- Settings
vim.g.mapleader = " "
vim.opt.hidden = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.optcompleteopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.showbreak = "> "
vim.opt.listchars = { nbsp = "⦸", tab = "→ ", eol = "↵", extends = "»", precedes = "«", trail = "·" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Mappings
vim.api.nvim_set_keymap("c", "<C-P>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-N>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true })
vim.api.nvim_set_keymap("n", "<CR>", "v:hlsearch ? ':nohlsearch<CR>' : '<CR>'", { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "<leader>s", ':let @+=@"<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>,", "<C-^>", { noremap = true })
vim.api.nvim_set_keymap("n", "[q", ":cprevious<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", { noremap = true })

-- Edit init.lua gets overridden by telescope
vim.api.nvim_set_keymap("n", "<leader>ev", ":edit $MYVIMRC<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>el", ":source $MYVIMRC<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-W>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-W>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W>l", { noremap = true })

require "gk.globals"
require "gk.plugins"

vim.cmd [[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]]

require("tokyonight").colorscheme()
