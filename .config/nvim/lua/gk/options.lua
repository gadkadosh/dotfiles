local indent = 4

vim.g.mapleader = " "
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.optcompleteopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.showbreak = "  > "
vim.opt.listchars = { nbsp = "⦸", tab = "→ ", eol = "↵", extends = "»", precedes = "«", trail = "·" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.updatetime = 200
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.clipboard = "unnamedplus"
vim.opt.pumblend = 5
vim.opt.laststatus = 3

local augroup_yank_highlight = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup_yank_highlight,
    callback = function()
        vim.highlight.on_yank()
    end,
})
