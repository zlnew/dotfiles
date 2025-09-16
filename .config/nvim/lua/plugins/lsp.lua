return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.inlay_hints = { enabled = false }

      opts.servers.html = {
        filetypes = { "html", "php" },
      }

      local vue_language_server_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
        configNamespace = "typescript",
      }

      local vtsls_config = {
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

      opts.servers = opts.servers or {}
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, vtsls_config)
      opts.servers.volar = vim.tbl_deep_extend("force", opts.servers.volar or {}, vue_ls_config)
    end,
  },
}
