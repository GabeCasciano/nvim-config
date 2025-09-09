local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "spell" },
  }),
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})

cmp.setup.filetype({ "markdown", "text" }, {
  sources = {
    { name = "spell" },
    { name = "buffer" },
    { name = "path" },
  },
})

vim.opt.spell = true
vim.opt.spellling = { "en_us" }
