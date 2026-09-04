return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    require("auto-session").setup({
      session_lens = {
        picker = "snacks",
      },
      bypass_save_filetypes = { "dap-repl", "dapui_console", "dapui_terminal" },
    })
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    vim.keymap.set("n", "<leader>fs", "<cmd>AutoSession search<CR>", { desc = "[F]ind [s]essions" })
  end,
}
