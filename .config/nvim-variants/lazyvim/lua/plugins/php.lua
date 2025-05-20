return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "pint" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "V13Axel/neotest-pest" },
    opts = {
      adapters = { "neotest-pest" },
    },
  },
}
