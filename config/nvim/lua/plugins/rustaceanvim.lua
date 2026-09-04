return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  config = function()
    -- vim.g.rustaceanvim = {
    --   dap = {
    --     -- Force configurations to load when the LSP client attaches
    --     autoload_configurations = true,
    --   },
    -- }

    vim.g.rustaceanvim = function()
      -- Exact native path mappings managed by the Arch Linux package layout
      local codelldb_path = "/usr/bin/codelldb"
      local liblldb_path = "/usr/lib/codelldb/lldb/lib/liblldb.so"

      return {
        dap = {
          -- Passes the native system binaries straight to the DAP client engine
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
          autoload_configurations = true, -- Prevents the Neotest nil value error
        },
        -- server = {
        --   on_attach = function(client, bufnr)
        --     -- Your custom LSP keymaps go here
        --   end,
        -- },
      }
    end
  end,
}
