return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require("mini.bracketed").setup()
    require("mini.cursorword").setup()
    require("mini.git").setup()
    require("mini.diff").setup({ view = { style = "sign" } })
    require("mini.indentscope").setup()
    require("mini.pairs").setup()
    require("mini.icons").setup()
  end
}
