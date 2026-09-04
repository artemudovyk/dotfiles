return {
  "otavioschwanck/arrow.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    -- or if using `mini.icons`
    -- { "echasnovski/mini.icons" },
  },
  -- opts = {
  --   show_icons = true,
  --   always_show_path = true,
  --   leader_key = ";", -- Recommended to be a single key
  --   buffer_leader_key = "m", -- Per Buffer Mappings
  --   separate_save_and_remove = true,
  -- },
  config = function()
    require("arrow").setup({
      show_icons = true,
      always_show_path = true,
      leader_key = ";", -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
      separate_save_and_remove = true,
    })
  end,
}
