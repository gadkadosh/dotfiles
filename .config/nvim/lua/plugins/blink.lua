return {
    "saghen/blink.cmp",
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        cmdline = {
            enabled = false
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = false
                }
            },
            documentation = {
                auto_show = true
            },
        },
        signature = { enabled = true },
        sources = {
            per_filetype = {
                sql = { 'snippets', 'dadbod', 'buffer' },
            },
            providers = {
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            },
        }
    },
}
