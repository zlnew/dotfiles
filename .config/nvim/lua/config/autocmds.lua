vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("UserColors", { clear = true }),
  callback = function()
    vim.defer_fn(function()
      require("hightlight").apply()
    end, 50)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("TextYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "YankedText",
      timeout = 100,
    })
  end,
})
