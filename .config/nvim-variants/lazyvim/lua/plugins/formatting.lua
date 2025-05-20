-- ~/.config/nvim/lua/plugins/formatting.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      vue = { "prettierd" },
      json = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      html = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
    },
    formatters = {
      prettierd = {
        command = "prettierd",
        args = { "$FILENAME" },
      },
    },
  },
}
