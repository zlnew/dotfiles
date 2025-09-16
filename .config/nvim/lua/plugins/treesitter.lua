return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "vue", "javascript", "typescript", "css", "html" })

      -- enable context_commentstring
      opts.context_commentstring = {
        enable = true,
        enable_autocmd = false,
      }
    end,
  },
}
