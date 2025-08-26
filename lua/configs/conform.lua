require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    cpp = { "clang_format" },
    c = { "clang_format" },
  },
  formatters = {
    prettier = {
      prepend_args = { "--tab-width", "4", "--use-tabs", "false" },
    },
    clang_format = {
      prepend_args = { "--style={BasedOnStyle: InheritParentConfig, ColumnLimit: 100}" }
    }
  },

  format_on_save = {
    timeout_ms = 250,
    lsp_fallback = true,
  },
}
