return {
  "folke/snacks.nvim",
  opts = {
    image = {
      -- your image configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
      win = {
        wo = {
          wrap = true,
        },
      },
      sources = {
        explorer = {
          layout = {
            auto_hide = { "input" },
          },
        },
      },
    },
  },
}
