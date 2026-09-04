vim.keymap.set("n", "<leader>rdc", function()
  vim.cmd.RustLsp("openDocs")
end, { desc = "Goto [R]ust [e]xternal [d]ocumentation for symbol under cursor" })

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>ra", function()
  vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { desc = "[R]ust code [a]ctions", silent = true, buffer = bufnr })

vim.keymap.set(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ "hover", "actions" })
  end,
  { desc = "Rust hover documentation", silent = true, buffer = bufnr }
)

vim.keymap.set("n", "<leader>rde", function()
  vim.cmd.RustLsp("explainError")
end, { desc = "Explain error", silent = true, buffer = bufnr })

vim.keymap.set("n", "<leader>rdi", function()
  vim.cmd.RustLsp("renderDiagnostic")
end, { desc = "Open diagnostic window for the current error", silent = true, buffer = bufnr })

-- vim.keymap.set("n", "<leader>rdi", function()
--   vim.cmd.RustLsp("renderDiagnostic")
--   -- Wait briefly then jump to the floating window
--   vim.defer_fn(function()
--     -- Find and focus the floating window
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--       local config = vim.api.nvim_win_get_config(win)
--       if config.relative ~= "" then -- it's a floating window
--         vim.api.nvim_set_current_win(win)
--         break
--       end
--     end
--   end, 100) -- 100ms delay
-- end, { desc = "[R]ust render [di]agnostic", silent = true, buffer = bufnr })

-- local diagnostic_shown = false
-- vim.keymap.set("n", "<leader>rdi", function()
--   if not diagnostic_shown then
--     -- First press: show the diagnostic
--     vim.cmd.RustLsp("renderDiagnostic")
--     diagnostic_shown = true
--     -- Set up an autocmd to reset the flag when the window closes
--     vim.api.nvim_create_autocmd("WinClosed", {
--       callback = function()
--         diagnostic_shown = false
--       end,
--       once = true,
--     })
--   else
--     -- Second press: jump into the floating window
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--       local config = vim.api.nvim_win_get_config(win)
--       if config.relative ~= "" then -- it's a floating window
--         vim.api.nvim_set_current_win(win)
--         diagnostic_shown = false -- Reset after jumping in
--         break
--       end
--     end
--   end
-- end, { desc = "[R]ust render [di]agnostic", silent = true, buffer = bufnr })

vim.keymap.set("n", "<leader>rdr", function()
  vim.cmd.RustLsp("relatedDiagnostics")
end, { desc = "Go to related diagnistic", silent = true, buffer = bufnr })
