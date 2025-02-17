return {
    "saghen/blink.cmp",
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
