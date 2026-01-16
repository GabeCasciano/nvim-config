require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "tex", "latex", "plaintex" },
--   callback = function()
--     vim.lsp.start {
--       name = "texlab",
--       cmd = { "texlab" },
--       root_dir = vim.fn.getcwd(),
--     }
--   end,
-- })



-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*.md",
--   callback = function()
--     local full_path = vim.fn.expand "%:p"
--     -- Print to verify it runs — remove this line once confirmed
--     vim.fn.jobstart({ "markdown_live", full_path, "-p 9999" }, {
--       detach = true,
--       stdout_buffered = true,
--       stderr_buffered = true,
--     })
--   end,
-- })
