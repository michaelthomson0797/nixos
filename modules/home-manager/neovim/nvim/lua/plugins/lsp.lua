return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = {'BufReadPre', 'BufNewFile'},
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", function() vim.lsp.buf.definition() end, 'goto defintion')
          map("gr", function() vim.lsp.buf.references() end, 'goto references')
          map("K", function() vim.lsp.buf.hover() end, 'hover')
          map("<leader>ws", function() vim.lsp.buf.workspace_symbol() end, 'workspace symbols')
          map("<leader>d", function() vim.diagnostic.open_float() end, 'diagnostic float')
          map("[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, 'next diagnostic')
          map("]d", function() vim.diagnostic.jump({ count = -1, float = true }) end, 'prev diagnostic')
          map("<leader>ca", function() vim.lsp.buf.code_action() end, 'code actions')
          map("<leader>rn", function() vim.lsp.buf.rename() end, 'rename')
          map("<C-h>", function() vim.lsp.buf.signature_help() end, 'signature help', "i")
        end
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Server configs
      local lsp = require('lspconfig')

      -- vue
      lsp.volar.setup({
        capabilities = capabilities,
      })

      -- typescript / javascript
      require'lspconfig'.ts_ls.setup{
        capabilities = capabilities,
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "",
              languages = {"javascript", "typescript", "vue"},
            },
          },
        },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" }
      }

      -- eslint
      lsp.eslint.setup({
        capabilities = capabilities,
      })

      -- tailwind
      lsp.tailwindcss.setup({
        capabilities = capabilities,
        root_dir = lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts')
      })

      -- html
      lsp.html.setup({
        capabilities = capabilities,
      })

      -- go
      lsp.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            usePlaceholders = true,
          }
        }
      })
      lsp.golangci_lint_ls.setup({
        capabilities = capabilities,
      })

      -- templ
      vim.filetype.add({ extension = { templ = "templ" } })
      lsp.templ.setup({
        capabilities = capabilities,
      })

      lsp.lua_ls.setup({
        capabilities = capabilities,
      })

      lsp.nil_ls.setup({
        capabilities = capabilities,
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
  }
}
