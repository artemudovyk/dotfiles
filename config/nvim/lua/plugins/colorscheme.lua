return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  { "sainnhe/gruvbox-material", priority = 1000 },
  -- {
  --   "navarasu/onedark.nvim",
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require("onedark").setup({
  --       style = "warm",
  --     })
  --   end,
  -- },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
  },
  -- {
  --   "RRethy/base16-nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
