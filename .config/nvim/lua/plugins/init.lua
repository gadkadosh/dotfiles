local function section_dap()
    local dap = require("dap").session()
    if dap then
        return " DEBUG"
    end
    return ""
end

return {
    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            require("mini.surround").setup()
            require("mini.statusline").setup({
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local git = MiniStatusline.section_git({ trunc_width = 40 })
                        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
                        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
                        local filename = MiniStatusline.section_filename({ trunc_width = 140 })
                        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                        local location = MiniStatusline.section_location({ trunc_width = 75 })
                        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
                        local dap_status = section_dap()

                        return MiniStatusline.combine_groups({
                            { hl = mode_hl, strings = { mode } },
                            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
                            "%<", -- Mark general truncate point
                            { hl = "MiniStatuslineFilename", strings = { filename } },
                            "%=", -- End left alignment
                            { hl = "MiniStatuslineModeOther", strings = { dap_status } },
                            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                            { hl = mode_hl, strings = { search, location } },
                        })
                    end,
                },
            })
        end,
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { "dmmulroy/ts-error-translator.nvim" },

    "tpope/vim-sleuth",
    {
        "tpope/vim-fugitive",
        enabled = false,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Navigation
                vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr })
                vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr })

                -- Actions
                vim.keymap.set({ "n", "v" }, "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "[H]unk [S]tage" })
                vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "[H]unk [U]ndo stage" })
                vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
                vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = bufnr })
                vim.keymap.set("n", "<leader>gB", gs.blame, { buffer = bufnr })
            end,
        },
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        opts = {},
    },

    -- My Plugins
    {
        dir = "~/Code/pixem.nvim",
        cmd = "Pixem",
        opts = {},
    },
    {
        dir = "~/Code/vimsum.nvim",
        cmd = { "SumTimes", "SumColumn" },
        keys = {
            { "<leader>st", ":SumTimes<CR>", mode = "v" },
            { "<leader>sc", ":SumColumn<CR>", mode = "v" },
        },
        opts = {},
    },
}
