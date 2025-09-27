return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.inlay_hints = { enabled = false }

      opts.servers.html = {
        filetypes = { "html", "php" },
      }

      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = "/home/zlnew/.bun/bin/vue-language-server",
        languages = { "vue" },
        configNamespace = "typescript",
      }

      local vts_ls_config = {
        cmd = { "bun", "/home/zlnew/.bun/bin/vtsls", "--stdio" },
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

      local vue_ls_config = {
        cmd = { "bun", "/home/zlnew/.bun/bin/vue-language-server", "--stdio" },
        on_init = function(client)
          client.handlers["tsserver/request"] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
            if #clients == 0 then
              vim.notify("Could not found `vtsls` lsp client, vue_ls would not work without it.", vim.log.levels.ERROR)
              return
            end
            local ts_client = clients[1]

            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
              title = "vue_request_forward",
              command = "typescript.tsserverRequest",
              arguments = { command, payload },
            }, { bufnr = context.bufnr }, function(_, r)
              local response_data = { { id, r.body } }
              client:notify("tsserver/response", response_data)
            end)
          end
        end,
      }

      local tailwindcss_ls_config = {
        cmd = { "bun", "/home/zlnew/.bun/bin/tailwindcss-language-server", "--stdio" },
        filetypes = {
          "typescript",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "vue",
        },
      }

      local intelephense_ls_config = {
        cmd = { "bun", "/home/zlnew/.bun/bin/intelephense", "--stdio" },
      }

      opts.servers = opts.servers or {}
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, vts_ls_config)
      opts.servers.volar = vim.tbl_deep_extend("force", opts.servers.volar or {}, vue_ls_config)
      opts.servers.tailwindcss = vim.tbl_deep_extend("force", opts.servers.tailwindcss or {}, tailwindcss_ls_config)
      opts.servers.intelephense = vim.tbl_deep_extend("force", opts.servers.intelephense or {}, intelephense_ls_config)
    end,
  },
}
