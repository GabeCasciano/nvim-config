vim.g.mapleader = " "

-- Allow project-local configs
vim.opt.exrc = true   -- look for a local config in the cwd
vim.opt.secure = true -- disable unsafe commands in local configs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.tex_flavor = "latex"
vim.opt.clipboard = "unnamedplus"

vim.wo.relativenumber = true
vim.wo.number = true

local lazy_config = require("config.lazy")

require("config.autocmds")
require("config.mappings")

require("lazy").setup("plugins")
