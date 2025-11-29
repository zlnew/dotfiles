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

      local phpactor_ls_config = {
        cmd = { "phpactor", "language-server" },
        filetypes = { "php" },
        root_dir = function(fname)
          return require("lspconfig").util.root_pattern("composer.json", ".git")(fname)
        end,
        init_options = {
          ["language_server_phpstan.enabled"] = false, -- optional tweak
        },
      }

      local gopls_ls_config = {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
        filetypes = {
          "go",
          "gomod",
          "gowork",
          "gotmpl",
        },
      }

      opts.servers = opts.servers or {}
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, vts_ls_config)
      opts.servers.volar = vim.tbl_deep_extend("force", opts.servers.volar or {}, vue_ls_config)
      opts.servers.tailwindcss = vim.tbl_deep_extend("force", opts.servers.tailwindcss or {}, tailwindcss_ls_config)
      opts.servers.intelephense = vim.tbl_deep_extend("force", opts.servers.intelephense or {}, intelephense_ls_config)
      opts.servers.phpactor = vim.tbl_deep_extend("force", opts.servers.phpactor or {}, phpactor_ls_config)
      opts.servers.gopls = vim.tbl_deep_extend("force", opts.servers.gopls or {}, gopls_ls_config)
    end,
  },
}
