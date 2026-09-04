return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Creates a beautiful graphical UI for debugging variables, stacks, etc.
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    -- Open/close DAP UI automatically when debugging starts/ends
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Toggle breakpoint on the current line
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
    -- Start or continue debugging
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
    -- Step Over (Execute current line and jump to the next line)
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
    -- Step Into (Go inside the function on the current line)
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
    -- Step Out (Finish current function and go back up a scope)
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

    vim.keymap.set("n", "<Leader>dq", dap.terminate, { desc = "DAP Terminate Session" })
  end,
}
