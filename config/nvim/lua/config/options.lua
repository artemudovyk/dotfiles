vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true -- use spaces instead of tabs

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"

vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.wrap = false

vim.opt.clipboard = "unnamedplus"

-- Nice and simple folding:
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

-- vim.o.pumborder = "single"

-- Show trailing symbols
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "→ " }

-- Disable bg highlight on autocompletions
vim.api.nvim_set_hl(0, "SnippetTabstop", { bg = "NONE" })

vim.opt.updatetime = 200
vim.o.shell = "fish"
