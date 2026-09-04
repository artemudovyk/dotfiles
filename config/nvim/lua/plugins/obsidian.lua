return {
  "obsidian-nvim/obsidian.nvim",
  enabled = false,
  version = "*",
  -- ---@module 'obsidian'
  -- ---@type obsidian.config
  -- opts = {
  --   legacy_commands = false, -- this will be removed in 4.0.0
  --   workspaces = {
  --     {
  --       name = "personal",
  --       path = "~/dev/udovyk/notes",
  --     },
  --   },
  -- },
  config = function()
    require("obsidian").setup({
      legacy_commands = false,
      workspaces = {
        {
          name = "personal",
          path = "~/dev/udovyk/notes",
        },
      },
      picker = {
        name = "snacks.picker", -- use snacks picker
      },
      note_id_func = require("obsidian.builtin").title_id,

      footer = {
        enabled = false,
      },

      -- Supress warnings
      ui = {
        enable = false,
      },
    })
  end,
}
