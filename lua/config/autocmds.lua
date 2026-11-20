vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    -- Only when a language server that can format is attached; otherwise
    -- vim.lsp.buf.format() just complains (e.g. on every markdown save).
    if #vim.lsp.get_clients({ bufnr = args.buf, method = "textDocument/formatting" }) > 0 then
      vim.lsp.buf.format({ bufnr = args.buf, async = false })
    end
  end
})
