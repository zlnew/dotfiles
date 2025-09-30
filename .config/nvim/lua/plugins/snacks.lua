return {
  "snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = false,
        },
        grep = {
          hidden = true,
          ignored = false,
        },
        explorer = {
          hidden = true,
          ignored = true,
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
