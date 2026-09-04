require("config.globals")
require("config.options")
require("config.lazy")
require("config.godot")
require("config.lsp")
require("config.autocmds")
require("config.keymaps")
require("config.filetypes")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Get all existing highlight groups
    local hl_groups = vim.api.nvim_get_hl(0, {})
    for hl_name, hl_attrs in pairs(hl_groups) do
      -- If a group uses italics, turn it off while keeping other styles (like bold)
      if hl_attrs.italic then
        vim.api.nvim_set_hl(0, hl_name, vim.tbl_extend("force", hl_attrs, { italic = false }))
      end
    end
  end,
})
vim.cmd("colorscheme catppuccin-macchiato")

-- TODO: move to snacks instead
-- vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#494d64" })
vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#363a4f" })
-- vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#494d64" })

-- Style all floating windows to look the same
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.max_width = opts.max_width or 80
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
