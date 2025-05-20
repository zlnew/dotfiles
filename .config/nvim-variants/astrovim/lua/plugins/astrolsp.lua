-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },

    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {},
        ignore_filetypes = {},
      },
      disabled = {
        "html-lsp",
        "intelephense",
        "vtsls",
        "ts_ls",
        "volar",
      },
      timeout_ms = 30000,
    },

    servers = {},

    ---@diagnostic disable: missing-fields
    config = (function()
      local vue_project_cache = {}

      local function is_vue_project(fname)
        local root = vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
        if not root then return false end
        if vue_project_cache[root] ~= nil then return vue_project_cache[root] end

        local files = vim.fn.glob(root .. "/**/*.vue", true, true)
        for _, filepath in ipairs(files) do
          if not filepath:match "node_modules" then
            vue_project_cache[root] = true
            return true
          end
        end

        vue_project_cache[root] = false
        return false
      end

      local ts_ls_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      local function get_ts_ls_config(fname)
        local filetypes = ts_ls_filetypes
        if is_vue_project(fname) then
          local filtered = {}
          for _, ft in ipairs(ts_ls_filetypes) do
            if ft ~= "typescript" then table.insert(filtered, ft) end
          end
          filetypes = filtered
        end
        return {
          filetypes = filetypes,
        }
      end

      return {
        volar = {
          filetypes = {
            "typescript",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "vue",
          },
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        },
        ts_ls = (function()
          local fname = vim.api.nvim_buf_get_name(0)
          return get_ts_ls_config(fname)
        end)(),
      }
    end)(),

    handlers = {},

    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },

    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },

    on_attach = function(client, bufnr) end,
  },
}
