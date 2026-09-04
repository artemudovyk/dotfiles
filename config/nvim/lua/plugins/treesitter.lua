-- if vim.g.treesitter_branch ~= "main" then
--   return {}
-- end

-- TODO: change for treesitter to run conditionally on known languages https://github.com/folke/snacks.nvim/issues/2651
-- on main branch, treesitter isn't started automatically
vim.api.nvim_create_autocmd({ "Filetype" }, {
  callback = function(event)
    local ignored_fts = {
      "snacks_dashboard",
      "snacks_notif",
      "snacks_input",
      "oil",
      "oil_preview",
      "lazy",
      "lazy_backdrop",
      "opencode_terminal",
      "prompt", -- bt: snacks_picker_input
      "grapple",
      "opencode_footer",
    }

    if vim.tbl_contains(ignored_fts, event.match) then
      return
    end

    -- make sure nvim-treesitter is loaded
    local ok, nvim_treesitter = pcall(require, "nvim-treesitter")

    -- no nvim-treesitter, maybe fresh install
    if not ok then
      return
    end

    local ft = vim.bo[event.buf].ft
    local lang = vim.treesitter.language.get_lang(ft)
    nvim_treesitter.install({ lang }):await(function(err)
      if err then
        vim.notify("Treesitter install error for ft: " .. ft .. " err: " .. err)
        return
      end

      pcall(vim.treesitter.start, event.buf)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end)
  end,
})

return {
  ---@module 'lazy'
  ---@type LazySpec
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      -- { "folke/ts-comments.nvim", opts = {} },
    },

    branch = "main",
    build = function()
      -- update parsers, if TSUpdate exists
      if vim.fn.exists(":TSUpdate") == 2 then
        vim.cmd("TSUpdate")
      end
    end,

    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {},

    config = function(_, opts)
      local ensure_installed = {
        "lua",
        "rust",
        "python",
        "toml",
        "bash",
        "csv",
        "dockerfile",
        "editorconfig",
        "gdscript",
        "gitignore",
        "json",
        "just",
        "sql",
        "yaml",
        -- Terraform
        "terraform",
        "hcl",
        -- JS
        "typescript",
        "javascript",
        "svelte",
        "graphql",
        "tsx",
      }

      -- make sure nvim-treesitter can load
      local ok, nvim_treesitter = pcall(require, "nvim-treesitter")

      -- no nvim-treesitter, maybe fresh install
      if not ok then
        return
      end

      nvim_treesitter.install(ensure_installed)
    end,
  },

  ---@module 'lazy'
  ---@type LazySpec
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",

    branch = "main",

    keys = {
      {
        "[f",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end,
        desc = "prev function",
        mode = { "n", "x", "o" },
      },
      {
        "]f",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end,
        desc = "next function",
        mode = { "n", "x", "o" },
      },
      {
        "[F",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
        end,
        desc = "prev function end",
        mode = { "n", "x", "o" },
      },
      {
        "]F",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
        end,
        desc = "next function end",
        mode = { "n", "x", "o" },
      },
      {
        "[a",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.outer", "textobjects")
        end,
        desc = "prev argument",
        mode = { "n", "x", "o" },
      },
      {
        "]a",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.outer", "textobjects")
        end,
        desc = "next argument",
        mode = { "n", "x", "o" },
      },
      {
        "[A",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.outer", "textobjects")
        end,
        desc = "prev argument end",
        mode = { "n", "x", "o" },
      },
      {
        "]A",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.outer", "textobjects")
        end,
        desc = "next argument end",
        mode = { "n", "x", "o" },
      },
      {
        "[s",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@block.outer", "textobjects")
        end,
        desc = "prev block",
        mode = { "n", "x", "o" },
      },
      {
        "]s",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@block.outer", "textobjects")
        end,
        desc = "next block",
        mode = { "n", "x", "o" },
      },
      {
        "[S",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_end("@block.outer", "textobjects")
        end,
        desc = "prev block",
        mode = { "n", "x", "o" },
      },
      {
        "]S",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end("@block.outer", "textobjects")
        end,
        desc = "next block",
        mode = { "n", "x", "o" },
      },
      {
        "gan",
        function()
          require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end,
        desc = "swap next argument",
      },
      {
        "gap",
        function()
          require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
        end,
        desc = "swap prev argument",
      },
      {
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        desc = "Select outer function",
        mode = { "x", "o" },
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        desc = "Select inner function",
        mode = { "x", "o" },
      },
      {
        "ac",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end,
        desc = "Select outer class",
        mode = { "x", "o" },
      },
      {
        "ic",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end,
        desc = "Select inner class",
        mode = { "x", "o" },
      },
      {
        "as",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
        end,
        desc = "Select local scope",
        mode = { "x", "o" },
      },
    },

    opts = {
      move = {
        enable = true,
        set_jumps = true,
      },
      swap = {
        enable = true,
      },
    },
  },
}

-- modified version of code from this config
--https://github.com/fredrikaverpil/dotfiles/blob/main/nvim-fredrik/lua/fredrik/plugins/core/treesitter.lua
-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     lazy = true,
--     event = "BufRead",
--     branch = "main",
--     build = ":TSUpdate",
--     ---@class TSConfig
--     opts = {
--       -- custom handling of parsers
--       ensure_installed = {
--         "lua",
--         -- Core
--         "rust",
--         "terraform",
--         "python",
--         -- FE
--         "typescript",
--         "javascript",
--         "svelte",
--         "graphql",
--         "tsx",
--         -- Misc
--         "toml",
--         "bash",
--         "csv",
--         "dockerfile",
--         "editorconfig",
--         "gdscript",
--         "gitignore",
--         "json",
--         "just",
--         "sql",
--         "yaml",
--       },
--     },
--     config = function(_, opts)
--       -- install parsers from custom opts.ensure_installed
--       if opts.ensure_installed and #opts.ensure_installed > 0 then
--         require("nvim-treesitter").install(opts.ensure_installed)
--         -- register and start parsers for filetypes
--         for _, parser in ipairs(opts.ensure_installed) do
--           local filetypes = parser -- In this case, parser is the filetype/language name
--           vim.treesitter.language.register(parser, filetypes)
--
--           vim.api.nvim_create_autocmd({ "FileType" }, {
--             pattern = filetypes,
--             callback = function(event)
--               vim.treesitter.start(event.buf, parser)
--             end,
--           })
--         end
--       end
--
--       -- Auto-install and start parsers for any buffer
--       vim.api.nvim_create_autocmd({ "BufRead" }, {
--         callback = function(event)
--           local bufnr = event.buf
--           local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
--
--           -- Skip if no filetype
--           if filetype == "" then
--             return
--           end
--
--           -- Check if this filetype is already handled by explicit opts.ensure_installed config
--           for _, filetypes in pairs(opts.ensure_installed) do
--             local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
--             if vim.tbl_contains(ft_table, filetype) then
--               return -- Already handled above
--             end
--           end
--
--           -- Get parser name based on filetype
--           local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
--           if not parser_name then
--             return
--           end
--           -- Try to get existing parser (helpful check if filetype was returned above)
--           local parser_configs = require("nvim-treesitter.parsers")
--           if not parser_configs[parser_name] then
--             return -- Parser not available, skip silently
--           end
--
--           local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)
--
--           if not parser_installed then
--             -- If not installed, install parser synchronously
--             require("nvim-treesitter").install({ parser_name }):wait(30000)
--           end
--
--           -- let's check again
--           parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)
--
--           if parser_installed then
--             -- Start treesitter for this buffer
--             vim.treesitter.start(bufnr, parser_name)
--           end
--         end,
--       })
--     end,
--   },
--   {
--     "nvim-treesitter/nvim-treesitter-context",
--     event = "BufRead",
--     enabled = false,
--     dependencies = {
--       "nvim-treesitter/nvim-treesitter",
--       event = "BufRead",
--     },
--     opts = {
--       multiwindow = true,
--     },
--   },
--   {
--     "nvim-treesitter/nvim-treesitter-textobjects",
--     branch = "main",
--     keys = {
--       {
--         "af",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
--         end,
--         desc = "Select outer function",
--         mode = { "x", "o" },
--       },
--       {
--         "if",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
--         end,
--         desc = "Select inner function",
--         mode = { "x", "o" },
--       },
--       {
--         "ac",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
--         end,
--         desc = "Select outer class",
--         mode = { "x", "o" },
--       },
--       {
--         "ic",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
--         end,
--         desc = "Select inner class",
--         mode = { "x", "o" },
--       },
--       {
--         "as",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
--         end,
--         desc = "Select local scope",
--         mode = { "x", "o" },
--       },
--     },
--     ---@module "nvim-treesitter-textobjects"
--     opts = { multiwindow = true },
--   },
-- }

-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     branch = "main",
--     lazy = false,
--     build = ":TSUpdate",
--     opts = {
--       ensure_installed = {
--         "lua",
--         -- Core
--         "rust",
--         "terraform",
--         "python",
--         -- FE
--         "typescript",
--         "javascript",
--         "svelte",
--         "graphql",
--         "tsx",
--         -- Misc
--         "toml",
--         "bash",
--         "csv",
--         "dockerfile",
--         "editorconfig",
--         "gdscript",
--         "gitignore",
--         "json",
--         "just",
--         "sql",
--         "yaml",
--       },
--       auto_install = false,
--       highlight = { enable = true },
--       indent = { enable = true },
--     },
--     config = function()
--       require'nvim-treesitter'.setup {
--   -- Directory to install parsers and queries to
--   install_dir = vim.fn.stdpath('data') .. '/site'
-- }
--     end
--   },
--   {
--     "nvim-treesitter/nvim-treesitter-textobjects",
--     event = "VeryLazy",
--     config = function()
--       require("nvim-treesitter-textobjects").setup({
--         select = {
--           -- Automatically jump forward to textobj, similar to targets.vim
--           lookahead = true,
--           -- You can choose the select mode (default is charwise 'v')
--           --
--           -- Can also be a function which gets passed a table with the keys
--           -- * query_string: eg '@function.inner'
--           -- * method: eg 'v' or 'o'
--           -- and should return the mode ('v', 'V', or '<c-v>') or a table
--           -- mapping query_strings to modes.
--           selection_modes = {
--             ["@parameter.outer"] = "v", -- charwise
--             ["@function.outer"] = "V", -- linewise
--             ["@class.outer"] = "<c-v>", -- blockwise
--           },
--           -- If you set this to `true` (default is `false`) then any textobject is
--           -- extended to include preceding or succeeding whitespace. Succeeding
--           -- whitespace has priority in order to act similarly to eg the built-in
--           -- `ap`.
--           --
--           -- Can also be a function which gets passed a table with the keys
--           -- * query_string: eg '@function.inner'
--           -- * selection_mode: eg 'v'
--           -- and should return true of false
--           include_surrounding_whitespace = false,
--         },
--       })
--
--       -- keymaps
--       -- You can use the capture groups defined in `textobjects.scm`
--       vim.keymap.set({ "x", "o" }, "af", function()
--         require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
--       end)
--       vim.keymap.set({ "x", "o" }, "if", function()
--         require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
--       end)
--       vim.keymap.set({ "x", "o" }, "ac", function()
--         require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
--       end)
--       vim.keymap.set({ "x", "o" }, "ic", function()
--         require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
--       end)
--       -- You can also use captures from other query groups like `locals.scm`
--       vim.keymap.set({ "x", "o" }, "as", function()
--         require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
--       end)
--     end,
--   },
-- }

-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     branch = "master",
--     lazy = false,
--     build = ":TSUpdate",
--     config = function()
--       local config = require("nvim-treesitter.configs")
--       config.setup({
--         ensure_installed = {
--           "lua",
--           "rust",
--           "terraform",
--           "typescript",
--           -- "python",
--           "toml",
--           "javascript",
--           "gdscript",
--           "godot_resource",
--           "gdshader",
--           "svelte",
--         },
--         auto_install = false,
--         highlight = { enable = true },
--         indent = { enable = true },
--       })
--     end,
--   },
-- {
--   "nvim-treesitter/nvim-treesitter-textobjects",
--   build = ":TSUpdate",
--   config = function()
--     require("nvim-treesitter.configs").setup({
--       textobjects = {
--         select = {
--           enable = true,
--
--           -- Automatically jump forward to textobj, similar to targets.vim
--           lookahead = true,
--
--           keymaps = {
--             -- You can use the capture groups defined in textobjects.scm
--             ["af"] = "@function.outer",
--             ["if"] = "@function.inner",
--           },
--           -- You can choose the select mode (default is charwise 'v')
--           --
--           -- Can also be a function which gets passed a table with the keys
--           -- * query_string: eg '@function.inner'
--           -- * method: eg 'v' or 'o'
--           -- and should return the mode ('v', 'V', or '<c-v>') or a table
--           -- mapping query_strings to modes.
--           selection_modes = {
--             ["@parameter.outer"] = "v", -- charwise
--             ["@function.outer"] = "V", -- linewise
--             ["@class.outer"] = "<c-v>", -- blockwise
--           },
--           -- If you set this to `true` (default is `false`) then any textobject is
--           -- extended to include preceding or succeeding whitespace. Succeeding
--           -- whitespace has priority in order to act similarly to eg the built-in
--           -- `ap`.
--           --
--           -- Can also be a function which gets passed a table with the keys
--           -- * query_string: eg '@function.inner'
--           -- * selection_mode: eg 'v'
--           -- and should return true or false
--           include_surrounding_whitespace = true,
--         },
--       },
--     })
--   end,
-- },
--   {
--     "nvim-treesitter/nvim-treesitter-textobjects",
--     branch = "main",
--     keys = {
--       {
--         "af",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
--         end,
--         desc = "Select outer function",
--         mode = { "x", "o" },
--       },
--       {
--         "if",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
--         end,
--         desc = "Select inner function",
--         mode = { "x", "o" },
--       },
--       {
--         "ac",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
--         end,
--         desc = "Select outer class",
--         mode = { "x", "o" },
--       },
--       {
--         "ic",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
--         end,
--         desc = "Select inner class",
--         mode = { "x", "o" },
--       },
--       {
--         "as",
--         function()
--           require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
--         end,
--         desc = "Select local scope",
--         mode = { "x", "o" },
--       },
--     },
--     ---@module "nvim-treesitter-textobjects"
--     opts = { multiwindow = true },
--   },
-- }
