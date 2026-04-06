return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = "BufReadPost",
	config = function()
		require("mason").setup()

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if ok then
			capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
		end

		local servers = {
			pyright = { cmd = { "pyright-langserver", "--stdio" } },
			clangd = { cmd = { "clangd" } },
			rust_analyzer = { cmd = { "rust-analyzer" } },
			lua_ls = { cmd = { "lua-language-server" } },
			texlab = { cmd = { "texlab" } },
			docker_language_server = {},
			docker_compose_language_service = {},
		}

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		for name, config in pairs(servers) do
			config.capabilities = capabilities
			vim.lsp.config(name, config)
		end

		vim.lsp.enable(vim.tbl_keys(servers))

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml" },
			callback = function()
				vim.bo.filetype = "yaml.docker-compose"
			end,
		})
	end,
}
