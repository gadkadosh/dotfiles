return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup({
            defaults = {
                formatter = "path.dirname_first",
            },
            grep = {
                actions = {
                    ["ctrl-q"] = {
                        fn = require("fzf-lua").actions.file_edit_or_qf,
                        prefix = "select-all+",
                    },
                },
            },
            winopts = {
                preview = {
                    horizontal = "right:50%",
                },
            },
        })
    end,
    cmd = "FzfLua",
    keys = {
        {
            "<leader><enter>",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>t",
            function()
                require("fzf-lua").files()
            end,
            desc = "Files",
        },
        {
            "<leader>ev",
            function()
                require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Neovim config files",
        },
        {
            "<leader>/",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Live grep",
        },
        {
            "<leader>g/",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "Grep word under cursor",
        },
        {
            "<leader>o",
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "Recent files",
        },
        {
            "<leader>?",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "Help tags",
        },
    },
}
