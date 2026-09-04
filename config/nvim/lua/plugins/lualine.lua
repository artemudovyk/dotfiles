return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = absolute path with tilde
            shorting_target = 40, -- Shorten path to leave 40 spaces in window
            symbols = {
              modified = "[+]",
              readonly = "[-]",
              unnamed = "[No Name]",
            },
          },
        },
      },
    })
  end,
}
