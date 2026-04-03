return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- THIS is the source that is currently "unknown"
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        -- Apply custom highlights to the completion window
                        winhighlight = "Normal:MyCmpNormal,FloatBorder:MyCmpBorder,CursorLine:MyCmpSel,Search:None",
                    },
                    documentation = {
                        winhighlight = "Normal:MyCmpDocNormal,FloatBorder:MyCmpDocBorder",
                    },
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
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
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip",  priority = 750 },
                }, {
                    { name = "buffer", priority = 500 },
                    { name = "path",   priority = 250 },
                }),
            })

            vim.api.nvim_set_hl(0, "MyCmpNormal", { bg = "#1e222a" })
            vim.api.nvim_set_hl(0, "MyCmpBorder", { fg = "#56b6c2" })
            vim.api.nvim_set_hl(0, "MyCmpSel", { bg = "#c678dd", fg = "#ffffff" })

            -- Specific logic for prose
            cmp.setup.filetype({ "markdown", "text" }, {
                sources = cmp.config.sources({
                    { name = "spell" },
                    { name = "buffer" },
                })
            })

            vim.opt.spell = true
            vim.opt.spelllang = { "en_us" }
        end
    }
}
