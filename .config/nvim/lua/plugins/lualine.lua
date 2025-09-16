return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      refresh = {
        statusline = 1500,
        tabline = 1500,
        winbar = 1500,
      },
      options = {
        globalstatus = true,
        theme = {
          normal = { c = { bg = "none" } },
          inactive = { c = { bg = "none" } },
        },
        section_separators = '',
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "branch", "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "diff" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "branch", "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "diff" },
      },
      extensions = {},
    },
  },
}
