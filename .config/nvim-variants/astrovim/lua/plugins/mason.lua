if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- install vue related servers
        "vue-language-server",
        "typescript-language-server",
        "tailwind-language-server",
        "html-lsp",
        "eslint-lsp",
        "eslint_d",
        "prettier",
        "prettierd",

        -- install php related servers
        "intelephense",
        "phpstan",
        "pint",

        -- install md related servers
        "markdownlint",

        -- install formatters
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
