-- Highlight yank section
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true -- Preserves list indent levels when wrapping

    -- Remap j/k to move by visual lines instead of physical lines
    vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
    vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
  end,
})
