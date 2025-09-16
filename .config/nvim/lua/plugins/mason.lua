return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      -- php
      "intelephense",
      "pint",

      -- js linter
      "eslint_d",
      "prettierd",

      -- vue
      "vtsls",
      "vue-language-server",

      -- css
      "tailwindcss-language-server",

      -- other
      "stylua",
      "shfmt",
    },
  },
}
