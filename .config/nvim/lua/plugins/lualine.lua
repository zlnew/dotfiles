return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    opts = function()
      return {
        refresh = {
          statusline = 1500,
          tabline = 1500,
          winbar = 1500,
        },
        options = {
          globalstatus = true,
          theme = "auto",
          section_separators = "",
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            "branch",
            { "filename", path = 1 },
            "diff",
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            "branch",
            { "filename", path = 1 },
            "diff",
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        extensions = {},
      }
    end,
    config = function(_, opts)
      local lualine = require("lualine")

      local function enforce_transparent_lualine()
        vim.schedule(function()
          local highlight_groups = vim.fn.getcompletion("lualine_", "highlight")
          for _, group in ipairs(highlight_groups) do
            local ok, definition = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
            if ok and definition and next(definition) then
              definition.bg = nil
              definition.ctermbg = nil
              vim.api.nvim_set_hl(0, group, definition)
            end
          end

          for _, group in ipairs({ "StatusLine", "StatusLineNC" }) do
            local ok, definition = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
            if ok and definition and next(definition) then
              definition.bg = nil
              definition.ctermbg = nil
              vim.api.nvim_set_hl(0, group, definition)
            end
          end
        end)
      end

      lualine.setup(opts)
      enforce_transparent_lualine()

      local group = vim.api.nvim_create_augroup("dotfiles_lualine_transparent", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = enforce_transparent_lualine,
      })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "Lualine",
        callback = enforce_transparent_lualine,
      })
    end,
  },
}
