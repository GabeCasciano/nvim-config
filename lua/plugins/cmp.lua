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
            require("luasnip.loaders.from_lua").lazy_load()

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
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "spell" }
                }),
            })

            vim.api.nvim_set_hl(0, "MyCmpNormal", { bg = "#32422b" })
            vim.api.nvim_set_hl(0, "MyCmpBorder", { fg = "#4c6642" })
            vim.api.nvim_set_hl(0, "MyCmpSel", { bg = "#529936", fg = "#ffffff" })

            -- Specific logic for prose
            cmp.setup.filetype({ "markdown", "text" }, {
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "spell" },
                    { name = "buffer" },
                    { name = "path" },
                })
            })

            vim.opt.spell = true
            vim.opt.spelllang = { "en_us" }
        end
    }
}
