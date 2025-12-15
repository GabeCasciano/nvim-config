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

local configs = {}

for _, server in ipairs(servers) do
  configs[server] = default_opts
end

return configs

