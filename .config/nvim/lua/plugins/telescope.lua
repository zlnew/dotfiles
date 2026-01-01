return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "node_modules", "vendor", ".git/" }
      },
      pickers = {
        find_files = { hidden = true }
      }
    })
  end,
}
