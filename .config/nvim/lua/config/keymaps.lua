local map = vim.keymap.set
local opts = { silent = true }

-- =========================================================
-- Leader
-- =========================================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- =========================================================
-- Clear search highlight
-- =========================================================
map("n", "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Escape and Clear hlsearch" })

-- =========================================================
-- Better Up/Down
-- =========================================================
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- =========================================================
-- Move Lines (normal + visual)
-- =========================================================
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move Line Up" })
map("n", "<A-Down>", "<cmd>m .+1<CR>==", { desc = "Move Line Down" })
map("n", "<A-Up>", "<cmd>m .-2<CR>==", { desc = "Move Line Up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move Line Down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move Line Up" })
map("i", "<A-Down>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move Line Down" })
map("i", "<A-Up>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })

-- =========================================================
-- Buffers
-- =========================================================
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>b#<CR>", { desc = "Switch to Other Buffer" })
map("n", "<leader> ", "<cmd>b#<CR>", { desc = "Switch to Other Buffer" })

-- =========================================================
-- Better Indenting (keeps selection)
-- =========================================================
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- =========================================================
-- Save / Quit
-- =========================================================
map("n", "<leader>ww", "<cmd>w<CR>", { desc = "Save File" })
map("n", "<leader>qq", "<cmd>q<CR>", { desc = "Quit" })

-- =========================================================
-- Windows
-- =========================================================
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<leader>wr", "<C-w>v", { desc = "Split Window Vertically" })
map("n", "<leader>wd", "<C-w>s", { desc = "Split Window Horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Equalize Splits" })
map("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close Current Split" })

-- =========================================================
-- Tabs
-- =========================================================
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<leader>tl", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<leader>th", "<cmd>tabprevious<CR>", { desc = "Prev Tab" })
map("n", "<leader>t<Right>", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<leader>t<Left>", "<cmd>tabprevious<CR>", { desc = "Prev Tab" })


-- =========================================================
-- LSP
-- =========================================================
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
map("n", "gK", function() return vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
map("n", "<C-k>", function() return vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, { desc = "Format Buffer" })

-- =========================================================
-- neo-tree
-- =========================================================
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neotree" })

-- =========================================================
-- telescope
-- =========================================================
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })
map("n", "fx", "<cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics" })
map("n", "fr", "<cmd>Telescope lsp_references<CR>", { desc = "Find references" })
map("n", "fi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Find implementations" })

-- =========================================================
-- lazygit
-- =========================================================
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })

-- =========================================================
-- grug-far
-- =========================================================
map("n", "<leader>sr",
  function()
    local grug = require("grug-far")
    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
    grug.open({
      transient = true,
      prefills = {
        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
      },
    })
  end, {
    desc = "Search and Replace"
  }
)

-- =========================================================
-- trouble
-- =========================================================
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cS", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP references/definitions/... (Trouble)" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
map("n", "[q",
  function()
    if require("trouble").is_open() then
      require("trouble").prev({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cprev)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, {
    desc = "Previous Trouble/Quickfix Item"
  }
)
map("n", "]q",
  function()
    if require("trouble").is_open() then
      require("trouble").next({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, {
    desc = "Next Trouble/Quickfix Item"
  }
)
