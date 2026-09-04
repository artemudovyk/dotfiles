return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },

  version = "1.*",
  opts = {
    keymap = {
      preset = "default",
      ["<C-CR>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      -- documentation = {
      --   auto_show = true,
      -- },
      trigger = {
        show_on_backspace = true,
        show_on_backspace_in_keyword = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      ghost_text = {
        enabled = true,
        show_with_menu = true,
      },
      menu = {
        -- border = "rounded",
        -- max_height = 15,

        -- Min width not supported with right alignment
        -- https://github.com/Saghen/blink.cmp/issues/424
        -- min_width = 30,
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", "source_name", gap = 1 },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                if ctx.source_id == "cmdline" then
                  return
                end
                return ctx.kind_icon .. ctx.icon_gap
              end,
            },
            source_name = {
              text = function(ctx)
                if ctx.source_id == "cmdline" then
                  return
                end
                return ctx.source_name:sub(1, 4)
              end,
            },
          },

          -- for highlighting in completion menu
          treesitter = {
            "lsp",
          },
        },
      },

      documentation = {
        auto_show = true,
        window = {
          -- border = "rounded",
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    signature = {
      enabled = true,
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
