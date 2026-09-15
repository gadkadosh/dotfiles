local function has_biome_config(ctx)
    return vim.fs.find({ "biome.json", "biome.jsonc" }, {
        path = ctx.filename,
        upward = true,
    })[1] ~= nil
end

local biome_filetypes = {
    css = true,
    graphql = true,
    html = true,
    javascript = true,
    javascriptreact = true,
    json = true,
    jsonc = true,
    typescript = true,
    typescriptreact = true,
}

local function uses_black(bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local start_path = filename ~= "" and vim.fs.dirname(filename) or vim.uv.cwd()

    local pyproject = vim.fs.find("pyproject.toml", {
        path = start_path,
        upward = true,
    })[1]

    if not pyproject then
        return false
    end

    for _, line in ipairs(vim.fn.readfile(pyproject)) do
        if line:match("^%s*%[tool%.black%]%s*$") then
            return true
        end
    end

    return false
end

return {
    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                css = { "biome", "prettier" },
                graphql = { "biome", "prettier" },
                html = { "biome", "prettier" },
                htmldjango = { "prettier" },
                javascript = { "biome", "biome-organize-imports", "prettier" },
                javascriptreact = { "biome", "biome-organize-imports", "prettier" },
                json = { "biome", "prettier" },
                jsonc = { "biome", "prettier" },
                lua = { "stylua" },
                terraform = { "terraform_fmt" },
                typescript = { "biome", "biome-organize-imports", "prettier" },
                typescriptreact = { "biome", "biome-organize-imports", "prettier" },
                python = function(bufnr)
                    if uses_black(bufnr) then
                        return { "black" }
                    end

                    return { "ruff_organize_imports", "ruff_format" }
                end,
                yaml = { "prettier" },
                sql = { "sql-formatter" },
            },
            formatters = {
                biome = {
                    condition = function(_, ctx)
                        return has_biome_config(ctx)
                    end,
                },
                ["biome-organize-imports"] = {
                    condition = function(_, ctx)
                        return has_biome_config(ctx)
                    end,
                },
                prettier = {
                    condition = function(_, ctx)
                        local filetype = vim.bo[ctx.buf].filetype
                        if biome_filetypes[filetype] and has_biome_config(ctx) then
                            return false
                        end

                        return vim.fs.find({
                            ".prettierrc",
                            ".prettierrc.json",
                            ".prettierrc.yml",
                            ".prettierrc.yaml",
                            ".prettierrc.json5",
                            ".prettierrc.js",
                            ".prettierrc.cjs",
                            "prettier.config.js",
                            "prettier.config.cjs",
                        }, {
                            path = ctx.filename,
                            upward = true,
                        })[1] ~= nil
                    end,
                },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
            vim.keymap.set({ "n", "v" }, "<leader>f", function()
                local start = vim.loop.hrtime()
                require("conform").format({ lsp_format = "fallback" })
                local elapsed = (vim.loop.hrtime() - start) / 1e6
                print(string.format("Format took %.2fms", elapsed))
            end)
        end,
    },
}
