vim.o.shellcmdflag = "-ic"

-- Remove LazyVim's default wrap_spell autocmd
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_wrap_spell")

-- Apply custom colors on ColorScheme change and VimEnter
local custom_colors_group = vim.api.nvim_create_augroup("UserColors", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = custom_colors_group,
  callback = function()
    pcall(require, "config.colorscheme")
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = custom_colors_group,
  callback = function()
    vim.defer_fn(function()
      pcall(require, "config.colorscheme")
    end, 100)
  end,
})
