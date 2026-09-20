vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("TextYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "YankedText",
      timeout = 100,
    })
  end,
})
