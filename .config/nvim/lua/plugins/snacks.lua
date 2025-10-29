return {
  "snacks.nvim",
  opts = {
    picker = {
      notifier = {
        enabled = true,
        level = vim.log.levels.ERROR,
        style = "minimal"
      },
      scroll = { enabled = false },
      animate = { enabled = false },
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
}
