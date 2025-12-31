return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- core
        "lua", "vim", "query",

        -- frontend
        "html", "css", "javascript", "typescript", "vue",

        -- backend
        "php",
        "go", "gomod", "gosum", "gowork",

        -- config & misc
        "json", "yaml", "bash", "markdown",
      })

      -- enable context_commentstring
      opts.context_commentstring = {
        enable = true,
        enable_autocmd = false,
      }
    end,
  },
}
