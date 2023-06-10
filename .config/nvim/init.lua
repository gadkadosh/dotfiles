-- Faster startup (caching lua modules)
pcall(require, "impatient")

require "gk.globals"
require "gk.options"
require "gk.mappings"
require "gk.diagnostic"
require "gk.plugins"

vim.cmd [[colorscheme tokyonight]]
