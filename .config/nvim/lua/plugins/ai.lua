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
          key_bindings = {
            accept = "<Tab>",
            next = "<M-]>",
            prev = "<M-[>",
            clear = "<C-]>",
          },
        },
      })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "Exafunction/codeium.nvim",
      },
    },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "codeium" },
        providers = {
          codeium = { name = "Codeium", module = "codeium.blink", async = true },
        },
      },
    },
  },

  --[[ { ]]
  --[[   "zbirenbaum/copilot.lua", ]]
  --[[   cmd = "Copilot", ]]
  --[[   event = "VimEnter", ]]
  --[[   config = function() ]]
  --[[     require("copilot").setup({ ]]
  --[[       suggestion = { ]]
  --[[         auto_trigger = true, ]]
  --[[         keymap = { ]]
  --[[           accept = "<C-l>", ]]
  --[[           next = "<M-]>", ]]
  --[[           prev = "<M-[>", ]]
  --[[           dismiss = "<C-]>", ]]
  --[[         }, ]]
  --[[       }, ]]
  --[[       panel = { ]]
  --[[         enabled = true, ]]
  --[[         auto_refresh = true, ]]
  --[[         keymap = { ]]
  --[[           open = "<M-CR>", ]]
  --[[           quit = "q", ]]
  --[[           jump_next = "<M-]>", ]]
  --[[           jump_prev = "<M-[>", ]]
  --[[         }, ]]
  --[[         layout = { ]]
  --[[           position = "bottom", -- | top | left | right ]]
  --[[           ratio = 0.4, ]]
  --[[         }, ]]
  --[[       }, ]]
  --[[     }) ]]
  --[[   end, ]]
  --[[ }, ]]
}
