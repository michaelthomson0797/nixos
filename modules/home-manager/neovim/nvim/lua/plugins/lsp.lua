return {
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

      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          local clients = vim.lsp.get_clients()
          for _, client in ipairs(clients) do
            local id = client.id
            vim.lsp.completion.enable(true, id, 1, { autotrigger = true })
            return
          end
        end,
      })

      -- Server configs
      local lsp = require('lspconfig')

      -- vue
      lsp.volar.setup({
      })

      -- typescript / javascript
      require'lspconfig'.ts_ls.setup{
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
      })

      -- tailwind
      lsp.tailwindcss.setup({
        root_dir = lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts')
      })

      -- html
      lsp.html.setup({
      })

      -- go
      lsp.gopls.setup({
        settings = {
          gopls = {
            completeFunctionCalls = false,
          }
        }
      })
      lsp.golangci_lint_ls.setup({
      })

      -- templ
      vim.filetype.add({ extension = { templ = "templ" } })
      lsp.templ.setup({})

      lsp.lua_ls.setup({})

      lsp.nil_ls.setup({})
    end,
  },
}
