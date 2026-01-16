-- -- list of language servers you want enabled
--
--
-- local servers = {
--   "html",
--   "cssls",
--   "pyright",
--   "lua_ls",
--   "clangd",
--   "texlab",
--   "rust_analyzer",
-- }
--
-- -- optional: capabilities (for autocompletion via nvim-cmp)
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if ok_cmp then
--   capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
-- end
--
-- -- optional: global default options for all servers
-- local default_opts = {
--   capabilities = capabilities,
--   on_attach = function(client, bufnr)
--     local opts = { buffer = bufnr, silent = true }
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--     vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--     vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--   end,
-- }
--
-- local configs = {}
--
-- for _, server in ipairs(servers) do
--   configs[server] = default_opts
-- end
--
-- return configs

-- 1. Map Filetypes to their Server Commands
-- Note: Make sure these binaries are installed (via Mason or System)
local servers = {
  python = { "pyright-langserver", "--stdio" },
  cpp = { "clangd" },
  c = { "clangd" },
  rust = { "rust-analyzer" },
  html = { "vscode-html-language-server", "--stdio" },
  css = { "vscode-css-language-server", "--stdio" },
  lua = { "lua-language-server" },
  tex = { "texlab" },
}

-- 2. Create a Native Autocommand for "Always Attach"
vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(servers),
  callback = function(args)
    local cmd = servers[vim.bo[args.buf].filetype]
    if not cmd then return end

    -- Custom Settings for specific languages
    local settings = {}
    if vim.bo[args.buf].filetype == "tex" then
      settings = {
        texlab = {
          build = { executable = "latexmk", args = { "-pdf", "-interaction=nonstopmode", "%f" }, onSave = true },
        },
      }
    end

    -- 3. THE NATIVE START CALL
    vim.lsp.start({
      name = vim.bo[args.buf].filetype,
      cmd = cmd,
      -- ALWAYS ATTACH logic:
      -- Look for project markers, but if none found, use the file's directory.
      root_dir = vim.fs.root(args.buf, { ".git", "pyproject.toml", "main.tex", "package.json" })
          or vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
      settings = settings,
      -- Add your keybinds here
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end,
    })
  end,
})
