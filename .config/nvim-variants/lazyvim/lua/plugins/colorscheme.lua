-- return {
--   {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     opts = {
--       styles = {
--         italic = false,
--         transparency = true
--       }
--     }
--   },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "rose-pine"
--     }
--   }
-- }
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      constrast = "soft",
      transparent_mode = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
