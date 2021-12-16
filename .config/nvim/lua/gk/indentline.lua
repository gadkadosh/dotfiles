require("indent_blankline").setup {
    char = "▏",
    use_treesitter = true,
    filetype_exclude = { "help", "man", "text", "packer", "lspinfo" },
    show_trailing_blankline_indent = false,
}
