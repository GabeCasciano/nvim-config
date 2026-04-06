return {
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "5547990",
		build = ":TSUpdate",
		config = function()
			local status, configs = pcall(require, "nvim-treesitter.configs")
			if not status then
				return
			end
			configs.setup({
				ensure_installed = {
					"c",
					"cpp",
					"lua",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"python",
					"latex",
					"bibtex",
					"diff",
					"json",
					"luadoc",
					"printf",
					"regex",
					"toml",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
					"dockerfile",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
