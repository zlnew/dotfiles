return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      php = { "pint" },
      javascript = { "prettierd" },
      typescript = { "prettierd", "eslint_d" },
      vue = { "prettierd", "eslint_d" },
      json = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      html = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      python = { "ruff_format", "ruff_organize_imports" },
    },
    formatters = {
      prettierd = {
        command = "prettierd",
        args = { "$FILENAME" },
      },
    },
  },
}
