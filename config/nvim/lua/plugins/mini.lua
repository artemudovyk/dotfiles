return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    require("mini.move").setup({
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- Move current line in Normal mode
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
    })
    -- TODO: do I really need it?
    require("mini.splitjoin").setup({
      mappings = {
        toggle = "gS",
        split = "",
        join = "",
      },
    })
  end,
}
