return {
  "nvim-neotest/neotest",
  lazy = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest") {
          -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules" and name ~=".direnv"
          end,
        },
      }
    })

    vim.keymap.set("n", "<leader>tt", function() require("neotest").run.run() end)
    vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end)
    vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end)
    vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end)
    vim.keymap.set("n", "<leader>tp", function() require("neotest").output_panel.toggle() end)
  end,
}
