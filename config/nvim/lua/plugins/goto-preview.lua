return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  enabled = true,
  config = function()
    require("goto-preview").setup({
      default_mappings = true,
    })
  end,
}
