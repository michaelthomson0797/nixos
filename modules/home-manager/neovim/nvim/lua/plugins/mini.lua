return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  version = false,
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

    require('mini.basics').setup({
      options = {
        extra_ui = true,
        win_borders = "bold"
      }
    })

    require('mini.comment').setup()

    local icons = require('mini.icons')
    icons.setup()
    icons.tweak_lsp_kind()

    require('mini.indentscope').setup({
      draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.none()
      }
    })

    require('mini.diff').setup()

    require('mini.extra').setup()

    require('mini.jump').setup()

    require('mini.jump2d').setup()

    local files = require('mini.files')
    files.setup()
    keymap("n", "<leader>fe", function() files.open(vim.api.nvim_buf_get_name(0)) end, { noremap = true, silent = true })

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
      local wrd = vim.fn.expand("<cword>")
      pick.builtin.grep({ pattern = wrd })
    end, { noremap = true, silent = true })

    -- require('mini.base16').setup({
    --   palette = {
    --     base00 = "#303446",
    --     base01 = "#292c3c",
    --     base02 = "#414559",
    --     base03 = "#51576d",
    --     base04 = "#626880",
    --     base05 = "#c6d0f5",
    --     base06 = "#f2d5cf",
    --     base07 = "#babbf1",
    --     base08 = "#e78284",
    --     base09 = "#ef9f76",
    --     base0A = "#e5c890",
    --     base0B = "#a6d189",
    --     base0C = "#81c8be",
    --     base0D = "#8caaee",
    --     base0E = "#ca9ee6",
    --     base0F = "#eebebe",
    --   }
    -- })
    --
    -- require('mini.hues').setup({
    --   foreground = '#fbf7f0',
    --   background = '#000000',
    --   n_hues     = 4,
    --   accent     = 'bg',
    --   saturation = 'high'
    -- })

    require('mini.splitjoin').setup()

    require('mini.trailspace').setup()
  end,
}
