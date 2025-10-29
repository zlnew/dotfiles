return {
  "snacks.nvim",
  opts = {
    animate = { enabled = false },
    scroll = { enabled = false },
    picker = {
      notifier = {
        enabled = true,
        level = vim.log.levels.ERROR,
        style = "minimal"
      },
      sources = {
        files = {
          hidden = true,
          ignored = false,
          layout = {
            fullscreen = true
          }
        },
        grep = {
          hidden = true,
          ignored = false,
          layout = {
            fullscreen = true
          }
        },
        explorer = {
          hidden = true,
          ignored = true,
          auto_close = true,
          layout = {
            preview = "main",
            preset = "ivy",
            hidden = { "input" }
          }
        },
      },
      formatters = {
        file = {
          truncate = 100,
        },
      },
    },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)
  end,
}
