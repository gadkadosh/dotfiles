-- Faster startup (caching lua modules)
pcall(require, "impatient")

require "gk.globals"
require "gk.options"
require "gk.mappings"
require "gk.diagnostic"
require "gk.plugins"

local ok, tokyonight = pcall(require, "tokyonight")
if ok then
    tokyonight.setup { transparent = true }
    tokyonight.colorscheme()
end
