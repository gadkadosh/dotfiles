local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Navigation
        vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Go to previous hunk" })
        vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Go to next hunk" })

        -- Actions
        vim.keymap.set({ "n", "v" }, "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "[H]unk [S]tage" })
        vim.keymap.set({ "n", "v" }, "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "[H]unk [R]eset" })
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "[H]unk [U]ndo stage" })
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
        vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "[H]unk [P]review" })
        vim.keymap.set("n", "<leader>hb", function()
            gs.blame_line { full = true }
        end, { buffer = bufnr, desc = "Blame line" })
        vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
    end,
}
