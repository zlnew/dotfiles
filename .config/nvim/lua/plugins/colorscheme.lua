return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Disable LazyVim's default colorscheme
      colorscheme = function()
        -- Load custom colors immediately
        require("config.colorscheme")
      end,
    },
  },
  -- Disable default colorscheme plugins
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim",       enabled = false },
}
