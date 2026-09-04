---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          -- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
          vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
        },
      },
    },
  },
}
