vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.editorconfig = true

vim.g.rustaceanvim = {
  server = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          features = "all",
        },
      },
    },
  },
}
