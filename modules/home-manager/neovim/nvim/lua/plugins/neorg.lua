return {
  "nvim-neorg/neorg",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-cmp",
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  version = "7.0.0", -- Pin Neorg to the latest stable release
  build = ":Neorg sync-parsers",
  cmd = "Neorg",
  config = function()
    require('neorg').setup({
      load = {
        ["core.defaults"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Neorg]" } },
        ["core.integrations.nvim-cmp"] = {},
        ["core.concealer"] = { config = { icon_preset = "basic" } },
        ["core.keybinds"] = {
          -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
          config = {
            default_keybinds = true,
            neorg_leader = "<Leader><Leader>",
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              Notes = "~/Notes",
            },
            default_workspace = "Notes"
          }
        },
      }
    })
  end,
}
