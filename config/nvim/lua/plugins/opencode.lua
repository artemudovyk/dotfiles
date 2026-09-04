return {
  "sudo-tee/opencode.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },
  },
  config = function()
    require("opencode").setup({
      default_mode = "plan",
      ui = {
        input = {
          text = {
            wrap = true, -- Wraps text inside input window
          },
        },
        output = {
          tools = {
            show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
            show_reasoning_output = false, -- Show reasoning/thinking steps output (default: true)
          },
        },
      },
      context = {
        cursor_data = {
          enabled = true, -- Include cursor position and line content in the context
          context_lines = 5, -- Number of lines before and after cursor to include in context
        },
      },
    })
  end,
}
