return {
  "Saghen/blink.cmp",
  optional = true,
  opts = function(_, opts)
    if not opts.keymap then opts.keymap = {} end
    opts.keymap["<Tab>"] = {
      "snippet_forward",
      function()
        if vim.g.ai_accept then return vim.g.ai_accept() end
      end,
      "fallback",
    }
    opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }

    opts.completion = {
      list = {
        max_items = 10,
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      ghost_text = { enabled = true },
    }

    opts.sources = {
      default = { "lsp", "path", "buffer" },
      providers = {
        path = {
          opts = {
            get_cwd = function(_) return vim.fn.getcwd() end,
          },
        },
      },
    }

    opts.fuzzy = {
      sorts = {
        "exact",
        -- defaults
        "score",
        "sort_text",
      },
    }
  end,
}
