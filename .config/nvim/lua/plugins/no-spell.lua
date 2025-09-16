return {
  -- override LazyVim default spell setting
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        spell = false,
      },
    },
  },

  -- double tap: disable spell per filetype just in case
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "markdown",
          "gitcommit",
          "text",
          "rst",
          "asciidoc",
          "latex",
        },
        callback = function()
          vim.opt_local.spell = false
        end,
      })
    end,
  },
}
