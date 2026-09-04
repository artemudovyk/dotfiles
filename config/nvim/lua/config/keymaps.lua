vim.keymap.set("n", "<Space>", "<Nop>", { desc = "Disable cursor movement on hold" })

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save buffer" })

vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Quit terminal mode" })
vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", { desc = "Quit terminal mode" })

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to LSP definition for a symbol under cursor" })

vim.keymap.set("n", "<leader>dt", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostic" })

vim.keymap.set("n", "<leader>dle", function()
  vim.diagnostic.config({ virtual_text = true })
end, { desc = "Toggle diagnostic virtual lines" })

vim.keymap.set("n", "<leader>/", "<cmd>noh<CR>", { desc = "Hide search highlight" })

-- vim.keymap.set({ "n", "i" }, "<leader>od", "<C-w>d", { desc = "Show diagnostic under the cursor" })

-- vim.keymap.set("n", "<leader>afl", vim.lsp.buf.format, { desc = "[A]uto [f]ormat with [L]SP" })

-- Windows
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]], { desc = "make the window biger vertically" })
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]], { desc = "make the window smaller vertically" })
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]], { desc = "make the window bigger horizontally" })
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]], { desc = "make the window smaller horizontally" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("i", "<C-h>", "<esc><C-w>h", { desc = "Move to left window" })
vim.keymap.set("i", "<C-l>", "<esc><C-w>l", { desc = "Move to right window" })
vim.keymap.set("i", "<C-j>", "<esc><C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("i", "<C-k>", "<esc><C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<leader>]v", "<C-w>v<C-w>l<C-]>", { desc = "Open tag in the vsplit" })
vim.keymap.set("n", "<leader>]s", "<C-w>s<C-w>j<C-]>", { desc = "Open tag in the vsplit" })
vim.keymap.set("n", "<leader>]t", "<C-w><C-]><C-w>T", { desc = "Open tag in new tab" })
-- Windows in terminal mode
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-l>", "<<C-\\><C-N>C-w>l", { desc = "Move to right window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Move to top window" })

-- Quickfix
vim.keymap.set("n", "<M-n>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<M-p>", "<cmd>cprev<CR>", { desc = "Prev quickfix item" })
vim.keymap.set("n", "<M-q>", "<cmd>cclose<CR>", { desc = "Close quickfix window" })

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tp", "<C-w>v<C-w>T", { desc = "New tab with current file" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close other tabs" })
vim.keymap.set("n", "<leader>tl", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>th", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tmh", ":-tabmove<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<leader>tml", ":+tabmove<CR>", { desc = "Move tab right" })
-- Jump to tab by number (Alt/Option + number)
for i = 1, 9 do
  vim.keymap.set("n", "<M-" .. i .. ">", ":tabn " .. i .. "<CR>", { desc = "Navigate to Nth tab" })
end
for i = 1, 9 do
  vim.keymap.set("n", "<leader>t" .. i, ":tabn " .. i .. "<CR>", { desc = "Navigate to Nth tab" })
end
vim.keymap.set("n", "<M-Left>", ":-tabmove<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<M-Right>", ":+tabmove<CR>", { desc = "Move tab right" })
