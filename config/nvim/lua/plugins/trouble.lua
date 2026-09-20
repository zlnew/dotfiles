return {
  "folke/trouble.nvim",
  lazy = true,
  cmd = { "Trouble" },
  opts = {
    warn_no_results = false,
    open_no_results = true,
    auto_preview = false,
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
}
