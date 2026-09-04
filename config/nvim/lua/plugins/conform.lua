return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        gdscript = { "gdformat" },
        python = { "ruff_format" },
        markdown = { "prettierd" },
        -- Terraform
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        -- JS
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        svelte = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        sql = { "pg_format" },
        nix = { "nixfmt", "statix", "deadnix" },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>af", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "[A]uto [f]ormat" })

    -- not sure about it yet. Should be called with `gq`, but it works for me with `gqq`
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
