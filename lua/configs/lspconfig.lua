-- local servers = { "html", "cssls", "pyright", "lua_ls", "clangd", "texlab", "rust-analyzer", "texlab" }
-- vim.lsp.enable(servers)
--
-- M = require "lspconfig"
--
-- M.pyright.setup {}
-- M.lua_ls.setup {}
-- M.clangd.setup {}
-- M.texlab.setup {}
-- M.rust_analyzer.setup {}
-- M.texlab.setup {}


-- modern Neovim LSP setup (Neovim ≥0.10)
local lspconfig = require("lspconfig")

-- list of language servers you want enabled
local servers = {
  "html",
  "cssls",
  "pyright",
  "lua_ls",
  "clangd",
  "texlab",
  "rust_analyzer",
}

-- optional: capabilities (for autocompletion via nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- optional: global default options for all servers
local default_opts = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
}

-- setup each server
for _, server in ipairs(servers) do
  local ok, conf = pcall(require, "lspconfig." .. server)
  if not ok then
    -- fallback for servers with hyphens in name
    conf = lspconfig[server]
  end

  if conf then
    conf.setup(default_opts)
  end
end
