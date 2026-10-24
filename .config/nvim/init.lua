vim.g.mapleader = " "

vim.opt.number = false
vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:1,hor:1"
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.pumblend = 5
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
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
vim.opt.termguicolors = true

vim.cmd("cabbrev W w")

vim.diagnostic.config({
    float = { border = "rounded", source = "if_many" },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    },
    virtual_text = { source = "if_many", spacing = 2 },
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })
vim.keymap.set("n", "<leader>D", vim.diagnostic.setqflist, { desc = "Open diagnostic Quickfix list" })

vim.keymap.set("c", "<C-A>", "<Home>")
vim.keymap.set("c", "<C-P>", "<Up>")
vim.keymap.set("c", "<C-N>", "<Down>")
vim.keymap.set("c", "<C-H>", "<Left>")
vim.keymap.set("c", "<C-L>", "<Right>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")

vim.keymap.set("n", "<leader>ev", ":edit $MYVIMRC<CR>", { desc = "[E]dit [V]im config" })
vim.keymap.set("n", "<leader>so", "<cmd>source %<CR>")
vim.keymap.set("n", "-", "<cmd>Explore<CR>")

local default_gx = vim.fn.maparg("gx", "n", false, true).callback
vim.keymap.set("n", "gx", function()
    if vim.bo.filetype == "lua" then
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1
        for start, _, repo, finish in line:gmatch("()(['\"])([%w_.-]+/[%w_.-]+)%2()") do
            if col > start and col < finish - 1 then
                vim.ui.open("https://github.com/" .. repo)
                return
            end
        end
    end
    default_gx()
end, { desc = "Open filepath, URI, or plugin repository" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
vim.keymap.set("n", "<leader>l", function()
    require("lazy").home()
end)

vim.keymap.set("n", "<leader>x", function()
    local filename = vim.api.nvim_buf_get_name(0)
    if filename == "" then
        return
    end

    local opts = {
        args = { filename },
        magic = { file = false },
    }

    if vim.bo.filetype == "lua" then
        vim.cmd.luafile(opts)
    elseif vim.bo.filetype == "vim" then
        vim.cmd.source(opts)
    elseif vim.bo.filetype == "python" then
        vim.cmd("!python3 " .. vim.fn.shellescape(filename, true))
    end
end)

local function unload_module(mod)
    mod = mod or vim.fn.input({ prompt = "Module name: " })
    if not mod then
        return
    end
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
    end,
})

vim.keymap.set("n", "<leader>z", unload_module)

vim.cmd.colorscheme("catppuccin")
