return {
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nordic").load()
        end,
    },

    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     opts = { style = "moon" },
    --     config = function()
    --         vim.cmd [[colorscheme tokyonight]]
    --     end
    -- },
}
