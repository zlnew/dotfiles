return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    -- Remove buffers and git sources
    opts.sources = { "filesystem" }

    -- Optional: remove tabs at the top
    opts.source_selector = {
      winbar = false,
      statusline = false,
      show_scrolled_off_parent_node = false,
    }

    -- Optional: automatically open filesystem
    opts.default_source = "filesystem"
  end,
}
