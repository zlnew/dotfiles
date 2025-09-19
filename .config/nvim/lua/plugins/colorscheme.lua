return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_transparent_background = "2"
      vim.cmd.colorscheme("gruvbox-material")

      -- 🔑 Force floating windows & terminals to be transparent
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "TermNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "TermNormalNC", { bg = "none" })
    end,
  },
}
