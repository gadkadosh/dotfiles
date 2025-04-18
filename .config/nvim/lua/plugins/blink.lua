return {
    "saghen/blink.cmp",
    version = "*",
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
    },
}
