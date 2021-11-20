local cmp = require "cmp"
cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
    },
    formatting = {
        format = require("lspkind").cmp_format {
            maxwidth = 40,
            menu = {
                nvim_lsp = "[LSP]",
                nvim_lua = "[NVIM]",
                luasnip = "[Snippet]",
                path = "[Path]",
                buffer = "[Buffer]",
            },
        },
    },
    experimental = {
        ghost_text = true,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 4 },
    },
}
