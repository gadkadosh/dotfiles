vim.g.mapleader = " "

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:1,hor:1"
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
vim.optcompleteopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.showbreak = "   > "
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.diagnostic.config({
    -- virtual_text = { source = "if_many", prefix = "●" },
    virtual_text = false,
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
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>")
vim.keymap.set("n", "]b", "<cmd>bnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")
vim.keymap.set("n", "]q", "<cmd>cnext<CR>")

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

require("gk.lazy")

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

local function getColumn()
    local lstart = vim.fn.line("v")
    local lend = vim.fn.line(".")
    if lstart > lend then
        local tmp = lend
        lend = lstart
        lstart = tmp
    end
    local nums = vim.fn.getline(lstart, lend)
    if type(nums) == "string" then
        return {}, 0, 0
    end

    return nums, lstart, lend
end

function SumTimes()
    local times, lstart, lend = getColumn()
    local hours = 0
    local minutes = 0
    for _, i in pairs(times) do
        local len = string.len(i)
        local m = tonumber(string.sub(i, len - 1, len))
        local h
        if len > 2 then
            h = tonumber(string.sub(i, 1, len - 2))
        else
            h = 0
        end
        hours = hours + h
        minutes = minutes + m
    end

    hours = hours + math.floor(minutes / 60)
    minutes = minutes % 60
    local total = string.format("%02d%02d", hours, minutes)
    vim.fn.append(lend, lstart .. "-" .. lend .. " Total: " .. total)
end

vim.keymap.set("v", "<leader>st", SumTimes)

function SumColumn()
    local nums, lstart, lend = getColumn()
    local total = 0
    for _, i in pairs(nums) do
        total = total + tonumber(i)
    end
    vim.fn.append(lend, lstart .. "-" .. lend .. " Sum: " .. total)
end

vim.keymap.set("v", "<leader>sc", SumColumn)
