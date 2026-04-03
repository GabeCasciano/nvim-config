return{
{
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_preview_options = {
        katex = 1,
        uml = 1,
      }
    end,
  }
  }
