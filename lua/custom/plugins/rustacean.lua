return {
  {
    'mrcjkb/rustaceanvim',
    -- To avoid being surprised by breaking changes,
    -- I recommend you set a version range
    version = '^9',
    -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
    -- No need for lazy.nvim to lazy-load it.
    lazy = false,
    dependencies = {
      'saghen/blink.cmp',
      'mfussenegger/nvim-dap',
    },
    init = function()
      vim.g.rustaceanvim = function()
        return {
          server = {
            cmd = function()
              local toolchain_rust_analyzer = vim.fs.joinpath(vim.env.HOME, '.cargo', 'bin', 'rust-analyzer')
              if vim.fn.executable(toolchain_rust_analyzer) == 1 then
                return { toolchain_rust_analyzer }
              end
              return { 'rust-analyzer' }
            end,
            capabilities = require('blink.cmp').get_lsp_capabilities(),
            default_settings = {
              ['rust-analyzer'] = {
                cargo = {
                  allFeatures = true,
                },
                check = {
                  command = 'clippy',
                },
                procMacro = {
                  enable = true,
                },
                inlayHints = {
                  bindingModeHints = {
                    enable = true,
                  },
                  chainingHints = {
                    enable = true,
                  },
                  closureCaptureHints = {
                    enable = true,
                  },
                  closureReturnTypeHints = {
                    enable = 'always',
                  },
                  discriminantHints = {
                    enable = 'always',
                  },
                  lifetimeElisionHints = {
                    enable = 'always',
                    useParameterNames = true,
                  },
                  parameterHints = {
                    enable = true,
                  },
                  typeHints = {
                    enable = true,
                  },
                },
              },
            },
          },
          dap = {
            autoload_configurations = true,
          },
        }
      end
    end,
  },
}
