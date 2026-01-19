-- 1. Setup Capabilities (The bridge to nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Add nvim-cmp specific capabilities manually if needed
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
end

-- 2. Map Filetypes to their Server Names and Commands
local servers = {
  python = { name = "pyright", cmd = { "pyright-langserver", "--stdio" } },
  cpp    = { name = "clangd", cmd = { "clangd" } },
  c      = { name = "clangd", cmd = { "clangd" } },
  rust   = { name = "rust-analyzer", cmd = { "rust-analyzer" } },
  html   = { name = "html", cmd = { "vscode-html-language-server", "--stdio" } },
  css    = { name = "cssls", cmd = { "vscode-css-language-server", "--stdio" } },
  lua    = { name = "lua_ls", cmd = { "lua-language-server" } },
  tex    = { name = "texlab", cmd = { "texlab" } },
}

-- 3. Create the Native Autocommand
vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(servers),
  callback = function(args)
    local server_config = servers[vim.bo[args.buf].filetype]
    if not server_config then return end

    -- Custom Settings for Texlab
    local settings = {}
    if vim.bo[args.buf].filetype == "tex" then
      settings = {
        texlab = {
          build = {
            executable = "latexmk",
            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
            onSave = true
          },
        },
      }
    elseif vim.bo[args.buf].filetype == "python" then
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      }
    end

    -- 4. THE NATIVE START CALL (v0.11 compliant)
    vim.lsp.start({
      name = server_config.name, -- Unique server name (e.g., 'pyright')
      cmd = server_config.cmd,
      root_dir = vim.fs.root(args.buf, { ".git", "pyproject.toml", "main.tex", "package.json" })
          or vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
      settings = settings,
      capabilities = capabilities, -- Crucial for nvim-cmp functionality
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- Optional: Add format on save for Python
        if client.name == "pyright" then
          -- pyright doesn't support formatting, you'd usually use null-ls/conform
        end
      end,
    })
  end,
})
