-- Servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("jsonls")
vim.lsp.enable("ts_ls") --- TypeScript
vim.lsp.enable("svelte")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("clangd") -- C

-- Nix
vim.lsp.config("nil_ls", {
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
      nix = {
        flake = {
          -- Set autoEvalInputs to false to stop background crashes on large flake inputs (like home-manager or nixpkgs)
          autoEvalInputs = false,
          -- Optionally set autoArchive to false as well
          autoArchive = false,
          -- Pass flags if you do want flake evaluation (prevents SIGABRT on impure setups)
          nixpkgsInputName = "nixpkgs",
        },
      },
    },
  },
})
vim.lsp.enable("nil_ls")

-- Terraform
vim.lsp.config("terraformls", {
  filetypes = { "terraform", "terraform-vars", "tf" },
  root_markers = { ".terraform/", ".terraform.lock.hcl" },
  init_options = {
    ["terraformls"] = {
      experimentalFeatures = {
        validateOnSave = true,
        prefillRequiredFields = true,
      },
    },
  },
  -- on_attach = function(client, bufnr)
  --   if client.server_capabilities then
  --     client.server_capabilities.semanticTokensProvider = nil
  --   end
  -- end,
})
vim.lsp.enable("terraformls")

-- Python
vim.lsp.enable("ruff")
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- Let Ruff handle imports
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})
vim.lsp.enable("basedpyright")

local virtual_text_enabled = true

local function toggle_virtual_text()
  virtual_text_enabled = not virtual_text_enabled
  vim.diagnostic.config({
    virtual_text = virtual_text_enabled,
  })
end

vim.keymap.set("n", "<leader>vt", toggle_virtual_text, {
  desc = "Toggle diagnostic virtual text",
})

vim.diagnostic.config({
  virtual_text = virtual_text_enabled,
  virtual_lines = false,
  underline = true,
  severity_sort = true,
  -- Do not update diagnostics while typing or in active modes
  update_in_insert = false,
  float = {
    border = "rounded",
    max_width = 80,
    max_height = 30,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "tailwindcss" then
      -- Disable the native document color feature
      vim.lsp.document_color.enable(false, { bufnr = args.buf })
    end
  end,
})
