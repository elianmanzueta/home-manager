return {
  -- Org
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  config = function()
    require("orgmode").setup({
      org_agenda_files = { "~/org/roam/professional/**", "~/org/roam/daily/" },

      org_startup_folded = "content",
      org_hide_leading_stars = true,
      org_agenda_span = "day",
      org_hide_emphasis_markers = true,
      org_tags_column = 0,
      org_ellipsis = "▼",
      org_agenda_skip_scheduled_if_done = true,
    })
  end,

  -- Org roam
  {
    "chipsenkbeil/org-roam.nvim",
    event = "VeryLazy",
    tag = "0.2.0",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
        tag = "0.7.0",
      },
    },
    config = function()
      require("org-roam").setup({
        directory = "~/org/roam",
        bindings = {
          prefix = "<Leader>r",
        },

        extensions = {
          dailies = {
            directory = "~/org/roam/daily",
            bindings = {
              goto_today = "<prefix>dt",
              capture_today = "<prefix>dT",
              goto_tomorrow = "<prefix>dm",
              capture_tomorrow = "<prefix>dM",
            },
            templates = {
              w = {
                description = "work-todo",
                template = "TODO %?\nCreated %T",
                target = "~/org/roam/daily/work-inbox.org",
                datetree = {
                  tree_type = "week",
                },
              },
              s = {
                description = "study",
                template = "#+title: %f\n#+filetags:%^{topics}",
              },
            },
          },
        },
      })
    end,
  },

  -- Org bullets
  {
    "nvim-orgmode/org-bullets.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
