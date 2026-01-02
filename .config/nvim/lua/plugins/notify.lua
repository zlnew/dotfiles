return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        stages = "static",
        timeout = 3000,
        render = "wrapped-compact",
      })
      vim.notify = notify
    end
  }
}
