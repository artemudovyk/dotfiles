return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  opts = {
    keywords = {
      TODO = { icon = " ", color = "info" },
      SECURITY = { icon = "󰒃 ", color = "warning", alt = { "SEC", "HARDEN" } },
    },
    highlight = {
      multiline = true,
    },
  },
  keys = {
    {
      "<leader>st",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "Todo",
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Todo/Fix/Fixme",
    },
  },
}
