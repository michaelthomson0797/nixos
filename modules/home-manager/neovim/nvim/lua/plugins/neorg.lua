return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Neorg]" } },
                ["core.integrations.nvim-cmp"] = {},
                ["core.concealer"] = {},
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = true,
                    },
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        }
                    }
                },
                ["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
                ["core.qol.toc"] = {},
                ["core.qol.todo_items"] = {},
                ["core.looking-glass"] = {},
                ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
                ["core.export"] = {},
                ["core.export.markdown"] = { config = { extensions = "all" } },
                ["core.summary"] = {},
                ["core.tangle"] = { config = { report_on_empty = false } },
                ["core.ui.calendar"] = {},
                ["core.journal"] = {
                    config = {
                        strategy = "flat",
                        workspace = "notes",
                    },
                },
            },
        })
    end,
}
