return {
  "saecki/crates.nvim",
  tag = "stable",
  event = { "BufRead Cargo.toml", "BufNewFile Cargo.toml" },
  opts = {
    text = {
      version = "  %s",
      upgrade = "  ↑ %s",
    },
    highlight = {
      version = "Comment",
      upgrade = "DiagnosticWarn",
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  },
  -- config = function()
  --   require("crates").setup()
  -- end,
}
