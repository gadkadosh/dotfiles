vim.g.mapleader = " "

vim.opt.number = true
vim.opt.mouse = "a"
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

vim.keymap.set("c", "<C-A>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-P>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-N>", "<Down>", { noremap = true })
vim.keymap.set("c", "<C-H>", "<Left>", { noremap = true })
vim.keymap.set("c", "<C-L>", "<Right>", { noremap = true })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("n", "<CR>", "v:hlsearch ? ':nohlsearch<CR>' : '<CR>'", { noremap = true, expr = true })
vim.keymap.set("n", "[b", ":bprevious<CR>", { noremap = true })
vim.keymap.set("n", "]b", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "[q", ":cprevious<CR>", { noremap = true })
vim.keymap.set("n", "]q", ":cnext<CR>", { noremap = true })

vim.keymap.set("n", "<C-h>", "<C-W>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-W>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-W>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-W>l", { noremap = true })

vim.keymap.set("n", "<leader>ev", ":edit $MYVIMRC<CR>", { noremap = true, desc = "[E]dit [V]im config" })
vim.keymap.set("n", "<leader>el", ":source $MYVIMRC<CR>", { noremap = true, desc = "Source Vim config" })
vim.keymap.set("n", "<leader>so", ":source %<CR>", { noremap = true })
vim.keymap.set("n", "-", function() vim.fn.execute("Explore") end)

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
end, { noremap = true })

local getColumn = function()
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
