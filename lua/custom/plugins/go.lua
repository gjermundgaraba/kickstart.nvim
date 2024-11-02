return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'go', 'gomod', 'gowork', 'gosum' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
              semanticTokens = true,
            },
          },
        },
      },
      setup = {
        gopls = function(_, _)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
              local client = vim.lsp.get_client_by_id(event.data.client_id)
              if client and not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                if not semantic then
                  return
                end
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end,
          })
        end,
      },
    },
  },
  -- Ensure Go tools are installed
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'goimports', 'gofumpt' } },
  },
  -- {
  --   'nvimtools/none-ls.nvim',
  --   optional = true,
  --   dependencies = {
  --     {
  --       'williamboman/mason.nvim',
  --       opts = { ensure_installed = { 'gomodifytags', 'impl' } },
  --     },
  --   },
  --   opts = function(_, opts)
  --     local nls = require 'null-ls'
  --     opts.sources = vim.list_extend(opts.sources or {}, {
  --       nls.builtins.code_actions.gomodifytags,
  --       nls.builtins.code_actions.impl,
  --       nls.builtins.formatting.goimports,
  --       nls.builtins.formatting.gofumpt,
  --     })
  --   end,
  -- },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { 'goimports', 'gofumpt' },
      },
    },
  },
}
