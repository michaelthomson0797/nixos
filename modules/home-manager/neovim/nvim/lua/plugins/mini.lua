return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    local keymap = vim.keymap.set

    require('mini.ai').setup { n_lines = 500 }

    require('mini.surround').setup()

    -- Simple and easy statusline.
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = true }
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    require('mini.comment').setup()

    require('mini.icons').setup()

    require('mini.cursorword').setup()

    require('mini.extra').setup()

    files = require('mini.files')
    files.setup()
    keymap("n", "<leader>fe", files.open, { noremap = true, silent = true })

    require('mini.git').setup()

    local hipatterns = require('mini.hipatterns')
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    require('mini.move').setup()

    require('mini.notify').setup()

    require('mini.pairs').setup()

    local pick = require('mini.pick')
    pick.setup()
    keymap("n", "<leader>ff", pick.builtin.files, { noremap = true, silent = true })
    keymap("n", "<leader>fg", pick.builtin.grep_live, { noremap = true, silent = true })
    keymap("n", "<leader>fwg", function()
      local wrd = vim.fn.expand("<cWORD>")
      pick.builtin.grep_live({ pattern = wrd })
    end, { noremap = true, silent = true })


  end,
}
