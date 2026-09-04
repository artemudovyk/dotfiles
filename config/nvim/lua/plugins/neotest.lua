return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          -- Automatically leverages rustaceanvim's background test configuration
          require("rustaceanvim.neotest"),
        },
        -- diagnostic = {
        --   enabled = false, -- Stops neotest from hijacking Neovim's diagnostic framework
        -- },
        floating = {
          border = "rounded", -- Matches your global look
          max_width = 160, -- Matches your maximum code width limit
          options = {},
        },
        output = { enabled = true, open_on_run = false },
      })
    end,
    keys = {
      -- Execution / Running Tests
      {
        "<leader>ttr",
        function()
          require("neotest").run.run()
        end,
        desc = "Test: Run Nearest",
      },
      {
        "<leader>ttf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Test: Run Current File",
      },
      {
        "<leader>tts",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "Test: Run Entire Suite",
      },
      {
        "<leader>ttl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Test: Run Last Session",
      },

      -- Debugging (Triggers nvim-dap & your arrow keys!)
      {
        "<leader>ttd",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Test: Debug Nearest",
      },

      -- Monitoring / Framework UI Controls
      {
        "<leader>tta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Test: Attach to Process",
      },
      {
        "<leader>ttx",
        function()
          require("neotest").run.stop()
        end,
        desc = "Test: Stop Running Test",
      },
      {
        "<leader>ttu",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Test: Toggle Summary Panel",
      },
      {
        "<leader>ttw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Test: Toggle Watch File",
      },

      -- Diagnostics & Output Inspection
      {
        "<leader>tto",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Test: Open Floating Output",
      },
      {
        "<leader>ttO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Test: Toggle Output Panel Window",
      },

      -- Quick Jump Navigation (Kept as [t and ]t for speed)
      {
        "[t",
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Test: Jump to Previous Failure",
      },
      {
        "]t",
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Test: Jump to Next Failure",
      },
      -- {
      --   "<leader>ttc", -- Test Toggle Compiler view (clears neotest logs out of the way)
      --   function()
      --     -- Look up Neotest's active internal diagnostic engine registration ID
      --     local neotest_ns = vim.diagnostic.get_namespaces()
      --     for ns_id, ns in pairs(neotest_ns) do
      --       if ns.name:find("neotest") then
      --         -- Read the current visibility status of just this namespace
      --         local current_config = vim.diagnostic.config(nil, ns_id) or {}
      --         local is_hidden = current_config.virtual_text == false
      --
      --         -- Toggle ONLY neotest virtual text while leaving rust-analyzer completely alone
      --         vim.diagnostic.config({
      --           virtual_text = is_hidden,
      --           underlines = is_hidden,
      --         }, ns_id)
      --
      --         vim.notify(is_hidden and "Neotest errors shown" or "Neotest errors hidden (Compiler clear)")
      --         return
      --       end
      --     end
      --     vim.notify("No active neotest errors found to toggle", vim.log.levels.WARN)
      --   end,
      --   desc = "Test: Toggle Neotest Logs (Free Compiler View)",
      -- },
      {
        "<leader>ttc",
        function()
          local active_buf = vim.api.nvim_get_current_buf()

          -- 1. Locate and flush the explicit low-level neotest extmark namespaces
          for _, ns_name in ipairs(vim.api.nvim_get_namespaces()) do
            if ns_name:find("neotest") then
              local ns_id = vim.api.nvim_create_namespace(ns_name)
              vim.api.nvim_buf_clear_namespace(active_buf, ns_id, 0, -1)
            end
          end

          -- 2. Fallback: Wipe standard diagnostic mirrors if your adapter copied them there
          pcall(function()
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.reset(neotest_ns, active_buf)
          end)

          vim.notify("Workspace flushed. Neotest markers cleared until next test run!")
        end,
        desc = "Test: Completely Clear Failure Signs & Gutter",
      },
    },
  },
}
