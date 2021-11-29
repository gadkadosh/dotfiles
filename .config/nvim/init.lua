-- Faster startup (caching lua modules)
pcall(require, "impatient")

require "gk.options"
require "gk.mappings"
require "gk.globals"
require "gk.plugins"

require("tokyonight").colorscheme()
