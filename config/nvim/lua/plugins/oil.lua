return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        -- ["yp"] = {
        --   desc = "Copy filepath to system clipboard",
        --   callback = function()
        --     require("oil.actions").copy_entry_path.callback()
        --     vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
        --   end,
        -- },
      },
    })
    vim.keymap.set("n", "<C-->", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
