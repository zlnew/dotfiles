local function read_theme()
  local theme_file = vim.fn.expand("~/.config/colors/theme")
  local file = io.open(theme_file, "r")
  if not file then
    return "gruvbox"
  end

  local theme = file:read("*l") or "gruvbox"
  file:close()

  theme = theme:gsub("%s+", "")
  if theme == "" then
    return "gruvbox"
  end

  local known = { gruvbox = true, tokyonight = true }
  if not known[theme] then
    return "gruvbox"
  end

  return theme
end

local function enforce_transparent_background()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "TermNormal",
    "TermNormalNC",
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

local active_theme = read_theme()

return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    cond = active_theme == "gruvbox",
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_transparent_background = "2"
      vim.cmd.colorscheme("gruvbox-material")
      enforce_transparent_background()
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    cond = active_theme == "tokyonight",
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        terminal_colors = true,
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",      -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
        on_colors = function() end,
        on_highlights = function() end,
      })
      vim.cmd.colorscheme("tokyonight-night")
      enforce_transparent_background()
    end,
  },
}
