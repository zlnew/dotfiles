local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.laststatus = 3
opt.cmdheight = 0
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true

-- Interaction
opt.mouse = "a"
opt.timeout = false
opt.timeoutlen = 0
opt.ttimeout = false
opt.ttimeoutlen = 0
opt.updatetime = 200
opt.confirm = true
opt.clipboard = "unnamedplus"

-- Indent
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10
opt.showmode = false

-- Files
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undolevels = 10000
opt.shada = [[!,'100,<50,s10,h]]
opt.autoread = true
opt.hidden = true
opt.fileencoding = "utf-8"
