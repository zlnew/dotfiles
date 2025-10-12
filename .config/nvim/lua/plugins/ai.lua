return {
  {
    "Exafunction/windsurf.nvim",
    enabled = false,
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
            lua = true,
            csv = true,
          },
          default_filetype_enabled = false,
          accept_fallback = "<Tab>",
          key_bindings = {
            accept = "<Tab>",
            next = "<M-]>",
            prev = "<M-[>",
            clear = "<C-l>",
          },
        },
      })

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.d.ts",
        callback = function()
          vim.cmd("Codeium Toggle")
        end,
      })
    end,
  },
}
