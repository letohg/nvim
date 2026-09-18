return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      install_dir = vim.fn.stdpath('data') .. '/site',
    },
    config = function(_, opts)
      require('nvim-treesitter').setup(opts)
      require('nvim-treesitter').install {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'go',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'rust',
        'query',
        'vim',
        'vimdoc',
        'zig',
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'bash', 'c', 'cpp', 'html', 'go', 'lua', 'markdown', 'rust', 'zig' },
        callback = function(args)
          vim.treesitter.start(args.buf)
        end,
      })

      function _G.custom_fold_expr()
        local line = vim.fn.getline(vim.v.lnum)
        if line:match '^%s*#%s*include' or line:match '^%s*#%s*define' then
          return 0
        end
        return vim.treesitter.foldexpr()
      end

      function _G.focus_fold()
        if vim.fn.foldlevel '.' == 0 then
          return
        end
        local view = vim.fn.winsaveview()
        vim.o.foldlevel = 0
        vim.cmd 'silent! foldopen!'
        vim.fn.winrestview(view)
      end

      function _G.focus_fold_toplevel()
        if vim.fn.foldlevel '.' == 0 then
          return
        end
        local view = vim.fn.winsaveview()
        vim.o.foldlevel = 0
        vim.cmd 'silent! foldopen'
        vim.fn.winrestview(view)
      end

      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'v:lua.custom_fold_expr()'
      vim.opt.foldenable = true
      vim.opt.foldlevelstart = 3
      vim.opt.foldtext =
        [[ repeat(' ', &shiftwidth * (v:foldlevel - 1)) . '▸ ' . trim(getline(v:foldstart)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)' . '...']]
      vim.opt.fillchars = 'fold: '
      vim.opt.foldnestmax = 3
      vim.opt.foldminlines = 1

      vim.keymap.set('n', 'zF', '<Cmd>lua _G.focus_fold()<CR>', {
        desc = 'Focus on current fold completely',
        silent = true,
      })
      vim.keymap.set('n', 'zf', '<Cmd>lua _G.focus_fold_toplevel()<CR>', {
        desc = 'Focus on current fold',
        silent = true,
      })
    end,
  },
}
