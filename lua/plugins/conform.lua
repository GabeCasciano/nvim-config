return {
    {
      "stevearc/conform.nvim",
      dependencies = { "mason.nvim" },
      lazy = true,
      cmd = "ConformInfo",
      init = function()
        -- Install the conform formatter on VeryLazy
        LazyVim.on_very_lazy(function()
          LazyVim.format.register({
            name = "conform.nvim",
            priority = 100,
            primary = true,
            format = function(buf)
              require("conform").format({ bufnr = buf })
            end,
            sources = function(buf)
              local ret = require("conform").list_formatters(buf)
              ---@param v conform.FormatterInfo
              return vim.tbl_map(function(v)
                return v.name
              end, ret)
            end,
          })
        end)
      end,
      opts = function()
        local plugin = require("lazy.core.config").plugins["conform.nvim"]
        if plugin.config ~= M.setup then
          LazyVim.error({
            "Don't set `plugin.config` for `conform.nvim`.\n",
            "This will break **LazyVim** formatting.\n",
            "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
          }, { title = "LazyVim" })
        end
        ---@type conform.setupOpts
        local opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            cpp = { "clang_format" },
            c = { "clang_format" },
            rust = { "rustfmt" },
            tex = { " latexindent" }

          },
          -- The options you set here will be merged with the builtin formatters.
          -- You can also define any custom formatters here.
          ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
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
  }
        }
        return opts
      end,
      config = M.setup,
    }
}
