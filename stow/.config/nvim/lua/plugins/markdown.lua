return {
  "yousefhadder/markdown-plus.nvim",
  ft = "markdown",

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      indent = {
        enabled = true,
        skip_level = 0,
      },

      heading = {
        width = "block",
      },

      anti_conceal = {
        ignore = {
          indent = true,
          virtual_lines = true,
          code_background = true,
        },
      },
    },
  },
}
