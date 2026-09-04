return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "folke/snacks.nvim",
      opts = {
        terminal = {},
      },
    },
  },
  event = "LspAttach",
  opts = {},
  config = function()
    vim.keymap.set({ "n", "x" }, "<leader>ca", function()
      require("tiny-code-action").code_action()
    end, { desc = "[C]ode [a]ctions", noremap = true, silent = true })
  end,
}
