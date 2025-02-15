return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        --
      })

      vim.cmd("colorscheme github_dark_dimmed")
    end,
  },
  -- {
  --   "echasnovski/mini.indentscope",
  --   version = false, -- wait till new 0.7.0 release to put it back on semver
  --   event = "LazyFile",
  --   opts = {
  --     -- symbol = "▏",
  --     symbol = ".",
  --     options = { try_as_border = true },
  --   },
  --   require("mini.indentscope").setup({
  --     draw = { animation = require("mini.indentscope").gen_animation.none() },
  --   }),
  --   init = function()
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = {
  --         "Trouble",
  --         "alpha",
  --         "dashboard",
  --         "fzf",
  --         "help",
  --         "lazy",
  --         "mason",
  --         "neo-tree",
  --         "notify",
  --         "snacks_dashboard",
  --         "snacks_notif",
  --         "snacks_terminal",
  --         "snacks_win",
  --         "toggleterm",
  --         "trouble",
  --       },
  --       callback = function()
  --         vim.b.miniindentscope_disable = true
  --       end,
  --     })
  --
  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "SnacksDashboardOpened",
  --       callback = function(data)
  --         vim.b[data.buf].miniindentscope_disable = true
  --       end,
  --     })
  --   end,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha",
  --       transparent_background = false,
  --       no_italic = true,
  --       integrations = {
  --         cmp = true,
  --         gitsigns = true,
  --         -- mini = {
  --         --   enabled = true,
  --         --   indentscope_color = "surface0",
  --         -- },
  --         noice = true,
  --         notify = true,
  --         nvimtree = true,
  --         neotree = true,
  --         treesitter = true,
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin",
  --   },
  -- },
}
