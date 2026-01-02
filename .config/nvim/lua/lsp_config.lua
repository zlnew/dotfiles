local M = {}

M.servers = {
  "gopls",
  "intelephense",
  "laravel_ls",
  "lua_ls",
  "phpactor",
  "tailwindcss",
  "vue_ls",
  "vtsls",
}

M.custom_configs = {
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'missing-fields' },
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
            "${3rd}/luv/library",
            "${3rd}/busted/library",
          },
          checkThirdParty = false,
          maxPreload = 10000,
          preloadFileSize = 10000,
        },
        telemetry = {
          enable = false
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          }
        },
        completion = {
          callSnippet = "Replace",
          keywordSnippet = "Replace",
        },
      },
    },
  },
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/home/zlnew/.bun/bin/vue-language-server",
              languages = { "vue" },
              configNamespace = "typescript",
            },
          },
        },
      },
      typescript = {
        preferences = {
          importModuleSpecifier = "non-relative",
        },
        format = {
          semicolons = "remove",
        },
      },
      javascript = {
        preferences = {
          importModuleSpecifier = "non-relative",
        },
        format = {
          semicolons = "remove",
        },
      },
    },
    filetypes = {
      "vue",
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
  },
}

function M.setup_custom_configs()
  for server_name, config in pairs(M.custom_configs) do
    vim.lsp.config(server_name, config)
  end
end

function M.enable_servers()
  vim.lsp.enable(M.servers)
end

function M.disable_servers(servers)
  local server_list = type(servers) == 'table' and servers or { servers }
  for _, server in ipairs(server_list) do
    vim.lsp.enable(server, false)
  end
end

function M.get_active_clients()
  return vim.lsp.get_clients({ bufnr = 0 })
end

function M.stop_client(client_name)
  local clients = vim.lsp.get_clients({ name = client_name })
  for _, client in ipairs(clients) do
    client.stop()
  end
end

function M.stop_all_clients()
  local clients = M.get_active_clients()
  for _, client in ipairs(clients) do
    client.stop()
  end
end

function M.restart_client(client_name)
  M.stop_client(client_name)
  vim.defer_fn(function()
    vim.lsp.enable(client_name)
  end, 100)
end

function M.restart_all_clients()
  local clients = M.get_active_clients()
  local client_names = {}

  for _, client in ipairs(clients) do
    table.insert(client_names, client.name)
    client.stop()
  end

  vim.defer_fn(function()
    for _, name in ipairs(client_names) do
      vim.lsp.enable(name)
    end
  end, 100)
end

function M.get_lsp_info()
  local clients = M.get_active_clients()
  if #clients == 0 then
    return 'No active LSP clients'
  end

  local info = {}
  for _, client in ipairs(clients) do
    table.insert(info, string.format(
      '%s (id: %d, root: %s)',
      client.name,
      client.id,
      client.root_dir or 'N/A'
    ))
  end

  return table.concat(info, '\n')
end

function M.setup_keybindings(bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts)

  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts)

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

  vim.keymap.set("n", "<leader>cf", function()
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ bufnr = bufnr, lsp_format = "fallback" })
    else
      vim.lsp.buf.format({ async = true })
    end
  end, opts)

  vim.keymap.set('n', '<leader>wA', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wR', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wL', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
end

function M.setup_autocommands()
  local lsp_group = vim.api.nvim_create_augroup('LspConfig', { clear = true })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if not client then return end

      M.setup_keybindings(bufnr)

      local has_blink = pcall(require, "blink.cmp")

      if not has_blink then
        if client.supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, bufnr)
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd('LspDetach', {
    group = lsp_group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        print(string.format('LSP detached: %s', client.name))
      end
    end,
  })

  vim.api.nvim_create_autocmd('LspProgress', {
    group = lsp_group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local value = args.data.params.value

      if value.kind == 'end' and client then
        print(string.format('%s: %s', client.name, value.message or 'Complete'))
      end
    end,
  })
end

function M.setup_commands()
  vim.api.nvim_create_user_command('LspStart', function(opts)
    if opts.args ~= '' then
      vim.lsp.enable(opts.args)
      print('Started LSP: ' .. opts.args)
    else
      M.enable_servers()
      print('Started all configured LSP servers')
    end
  end, {
    nargs = '?',
    complete = function()
      return M.servers
    end,
  })

  vim.api.nvim_create_user_command('LspStop', function(opts)
    if opts.args ~= '' then
      M.stop_client(opts.args)
      print('Stopped LSP: ' .. opts.args)
    elseif opts.bang then
      M.stop_all_clients()
      print('Stopped all LSP clients in buffer')
    else
      M.stop_all_clients()
    end
  end, {
    nargs = '?',
    bang = true,
    complete = function()
      local clients = M.get_active_clients()
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return names
    end,
  })

  vim.api.nvim_create_user_command('LspRestart', function(opts)
    if opts.args ~= '' then
      M.restart_client(opts.args)
      print('Restarting LSP: ' .. opts.args)
    else
      M.restart_all_clients()
      print('Restarting all LSP clients in buffer')
    end
  end, {
    nargs = '?',
    complete = function()
      local clients = M.get_active_clients()
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return names
    end,
  })

  vim.api.nvim_create_user_command('LspInfo', function()
    vim.cmd('checkhealth vim.lsp')
  end, {})

  vim.api.nvim_create_user_command('LspClients', function()
    print(M.get_lsp_info())
  end, {})
end

function M.setup_diagnostics()
  vim.diagnostic.config({
    virtual_lines = {
      current_line = false,
      severity = vim.diagnostic.severity.ERROR,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = true,
      header = '',
      prefix = '',
    },
  })
end

function M.setup()
  M.setup_custom_configs()
  M.enable_servers()
  M.setup_autocommands()
  M.setup_commands()
  M.setup_diagnostics()
end

return M
