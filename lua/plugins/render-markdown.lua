return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		ft = { "markdown" },
		opts = {
			-- Fixes the 'expected: nil, got: boolean' error
			checkbox = {
				enabled = true,
				position = "inline",
			},
			-- Addresses the warnings about missing LaTeX parsers
			latex = {
				enabled = false,
			},
		},
		config = function()
			require("render-markdown").setup({})
		end,
	},
}
