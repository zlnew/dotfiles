return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.inlay_hints = { enabled = false }

      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = "/home/zlnew/.bun/bin/vue-language-server",
        languages = { "vue" },
        configNamespace = "typescript",
      }

      local vts_ls_config = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },
        filetypes = {
          "typescript",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "vue",
        },
      }

      local vue_ls_config = {}

      local tailwindcss_ls_config = {
        filetypes = {
          "typescript",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "vue",
        },
      }

      local intelephense_ls_config = {}

      opts.servers = opts.servers or {}
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, vts_ls_config)
      opts.servers.volar = vim.tbl_deep_extend("force", opts.servers.volar or {}, vue_ls_config)
      opts.servers.tailwindcss = vim.tbl_deep_extend("force", opts.servers.tailwindcss or {}, tailwindcss_ls_config)
      opts.servers.intelephense = vim.tbl_deep_extend("force", opts.servers.intelephense or {}, intelephense_ls_config)
    end,
  },
}
