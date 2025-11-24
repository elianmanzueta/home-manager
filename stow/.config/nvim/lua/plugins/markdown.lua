return {
  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    --- Configuration options for `markview.nvim`.
    ---@class markview.config
    ---
    ---@field experimental? markview.config.experimental
    ---@field html? markview.config.html
    ---@field latex? markview.config.latex
    ---@field markdown? markview.config.markdown
    ---@field markdown_inline? markview.config.markdown_inline
    ---@field preview? markview.config.preview
    ---@field renderers? table<string, function>
    ---@field typst? markview.config.typst
    ---@field yaml? markview.config.yaml
    opts = {
      markdown = {

        headings = {
          org_indent = true,
        },

        list_items = {
          shift_width = 2,
        },

        code_blocks = {
          style = "simple",
        },

        markdown_inline = {},
      },
    },
  },
}
