return {
  "folke/trouble.nvim",
  lazy = true,
  cmd = { "Trouble" },
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
}
