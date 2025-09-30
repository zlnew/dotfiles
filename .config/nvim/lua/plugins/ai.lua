return {
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          filetypes = {
            php = true,
            vue = true,
            typescript = true,
            javascript = true,
            html = true,
            css = true,
          },
          default_filetype_enabled = false,
          key_bindings = {
            accept = "<Tab>",
            next = "<M-]>",
            prev = "<M-[>",
            clear = "<C-l>",
          },
        },
      })
    end,
  },
  --[[ { ]]
  --[[   "saghen/blink.cmp", ]]
  --[[   dependencies = { ]]
  --[[     { ]]
  --[[       "Exafunction/codeium.nvim", ]]
  --[[     }, ]]
  --[[   }, ]]
  --[[   opts = { ]]
  --[[     sources = { ]]
  --[[       default = { "lsp", "path", "snippets", "buffer", "codeium" }, ]]
  --[[       providers = { ]]
  --[[         codeium = { name = "Codeium", module = "codeium.blink", async = true }, ]]
  --[[       }, ]]
  --[[     }, ]]
  --[[   }, ]]
  --[[ }, ]]
}
