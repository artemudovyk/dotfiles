vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true -- Use spaces instead of tabs
vim.opt_local.shiftwidth = 2 -- Number of spaces for indentation
vim.opt_local.tabstop = 2 -- Number of spaces that a tab counts for
vim.opt_local.softtabstop = 2

vim.keymap.set("n", "<leader>xl", ":.lua<CR>", { desc = "E[x]ecute [l]ine" })
vim.keymap.set("n", "<leader>xf", ":%lua<CR>", { desc = "E[x]ecute [f]ile" })
vim.keymap.set("v", "<leader>xs", ":lua<CR>", { desc = "E[x]ecute [s]election" })
