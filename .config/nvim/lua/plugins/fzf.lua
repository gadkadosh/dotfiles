return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup(
            {
                grep = {
                    actions = {
                        ["ctrl-q"] = {
                            fn = require("fzf-lua").actions.file_edit_or_qf,
                            prefix = "select-all+"
                        }
                    }
                },
                winopts = {
                    preview = {
                        horizontal = "right:50%",
                    }
                },
            })
    end,
    keys = {
        { "<leader><enter>", function() require("fzf-lua").buffers() end },
        { "<leader>t",       function() require("fzf-lua").files() end },
        { "<leader>ev",      function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end },
        { "<leader>/",       function() require("fzf-lua").live_grep() end },
        { "<leader>g/",      function() require("fzf-lua").grep_cword() end },
        { "<leader>o",       function() require("fzf-lua").oldfiles() end },
        { "<leader>?",       function() require("fzf-lua").helptags() end },
    }
}
