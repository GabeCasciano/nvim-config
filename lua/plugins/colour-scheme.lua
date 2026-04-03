return {
    -- {
    --     "AlexvZyl/nordic.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("nordic").load()
    --     end,
    -- },


    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     opts = { style = "moon" },
    --     config = function()
    --         vim.cmd [[colorscheme tokyonight]]
    --     end
    -- },

    {
        "navarasu/onedark.nvim",
        version = "v0.1.0", -- Pin to legacy version
        priority = 1000,
        config = function()
            require('onedark').setup {
                style = 'warmer'
            }
            require('onedark').load()
        end
    }

}
