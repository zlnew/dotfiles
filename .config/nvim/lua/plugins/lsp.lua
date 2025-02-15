return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Modify or add to the existing options
      opts.servers = opts.servers or {}
      opts.servers.html = {
        filetypes = { "html", "php" },
      }
      opts.servers.volar = {
        filetypes = { "typescript", "javascript", "vue" },
        init_options = {
          vue = { hybridMode = true },
          -- Uncomment and configure TypeScript SDK path if needed
          -- typescript = {
          --   tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
          -- },
        },
      }
      -- Configure tsserver with max memory limit
      opts.servers.tsserver = {
        cmd = {
          "node",
          vim.fn.stdpath("data")
            .. "/mason/packages/typescript-language-server/lib/node_modules/typescript-language-server/lib/cli.js",
          "--stdio",
          "--max-memory=4096", -- Set memory limit (in MB)
        },
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      }

      opts.inlay_hints = { enabled = false }

      -- Set the LSP log level to 'off'
      vim.lsp.set_log_level("off")
    end,
  },
}
