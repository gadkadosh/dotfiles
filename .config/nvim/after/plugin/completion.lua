local ok, cmp = pcall(require, "cmp")
if not ok then
    return
end

cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
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
    sources = cmp.config.sources {
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
    },
}
