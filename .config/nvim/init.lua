vim.g.mapleader = " "

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:1,hor:1"
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.pumblend = 5
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.listchars = { nbsp = "␣", tab = "→ ", eol = "↵", extends = "»", precedes = "«", trail = "·" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.showbreak = "   > "
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.winborder = "rounded"

vim.diagnostic.config({
    -- virtual_text = { source = "if_many", prefix = "●" },
    float = { border = "rounded", source = "if_many" },
    severity_sort = true,
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

vim.keymap.set("c", "<C-A>", "<Home>")
vim.keymap.set("c", "<C-P>", "<Up>")
vim.keymap.set("c", "<C-N>", "<Down>")
vim.keymap.set("c", "<C-H>", "<Left>")
vim.keymap.set("c", "<C-L>", "<Right>")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<CR>", "v:hlsearch ? ':nohlsearch<CR>' : '<CR>'", { expr = true })

vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")

vim.keymap.set("n", "<leader>ev", ":edit $MYVIMRC<CR>", { desc = "[E]dit [V]im config" })
vim.keymap.set("n", "<leader>el", ":source $MYVIMRC<CR>", { desc = "Source Vim config" })
vim.keymap.set("n", "<leader>so", "<cmd>source %<CR>")
vim.keymap.set("n", "-", "<cmd>Explore<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.keymap.set("n", "<leader>x", function()
    local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local filename = vim.api.nvim_buf_get_name(0)
    print([[executing ]] .. filename)
    if ft == "lua" then
        vim.cmd([[luafile ]] .. filename)
    elseif ft == "python" then
        vim.cmd([[!python3 ]] .. filename)
    elseif ft == "vim" then
        vim.cmd([[source ]] .. filename)
    end
end)

local function unload_module(mod)
    mod = mod or vim.fn.input({ prompt = "Module name: " })
    if not mod then return end
    package.loaded[mod] = nil
    print("Unloading module: " .. mod)
end

vim.api.nvim_create_user_command("Unload", function(opts)
    unload_module(opts.fargs[1])
end, {
    nargs = "?",
    complete = function(ArgLead)
        local mods = {}
        for k, _ in pairs(package.loaded) do
            if string.find(k, ArgLead) then
                table.insert(mods, k)
            end
        end
        return mods
    end
})

vim.keymap.set("n", "<leader>z", unload_module)
