return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  ft = { "markdown", "avante", "copilot-chat", "opencode_output" },
  opts = {
    anti_conceal = { enabled = true },
    file_types = { "markdown", "opencode_output" },
    link = {
      enabled = true,
      image = "󰥶 ",
      email = "󰇮 ",
      hyperlink = "󰌹 ",
      -- Highlight group for the link text itself
      highlight = "RenderMarkdownLink",
      wiki = { icon = "󱞁 ", highlight = "RenderMarkdownWikiLink" },
      custom = {
        web = {
          pattern = "^http",
          -- Separate icon highlight from link text highlight
          icon = "󰌹 ",
          icon_highlight = "RenderMarkdownLinkIcon",
          highlight = "RenderMarkdownLink",
        },
      },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- Enable conceal level for markdown
    vim.opt.conceallevel = 2

    -- Fix Conceal highlight group artifacts
    vim.api.nvim_set_hl(0, "Conceal", { fg = "NONE", bg = "NONE" })

    -- Standard link styling (text keeps theme's link color/underline)
    vim.api.nvim_set_hl(0, "RenderMarkdownLink", { link = "@markup.link.url" })

    -- Dedicated icon styling (removes underline specifically from icon)
    vim.api.nvim_set_hl(0, "RenderMarkdownLinkIcon", { link = "@markup.link.url", underline = false })
  end,
}
