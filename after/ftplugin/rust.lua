local function rust_lsp(command)
  return function()
    vim.cmd.RustLsp(command)
  end
end

local opts = { buffer = true, silent = true }

vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Rust: Hover documentation' }))
vim.keymap.set('n', '<leader>rr', rust_lsp('runnables'), vim.tbl_extend('force', opts, { desc = 'Rust: Run target' }))
vim.keymap.set('n', '<leader>rt', rust_lsp('testables'), vim.tbl_extend('force', opts, { desc = 'Rust: Run tests' }))
vim.keymap.set('n', '<leader>rd', rust_lsp('debuggables'), vim.tbl_extend('force', opts, { desc = 'Rust: Debug target' }))
vim.keymap.set('n', '<leader>ra', rust_lsp('codeAction'), vim.tbl_extend('force', opts, { desc = 'Rust: Code action' }))
vim.keymap.set('n', '<leader>re', rust_lsp('explainError'), vim.tbl_extend('force', opts, { desc = 'Rust: Explain error' }))
vim.keymap.set('n', '<leader>rm', rust_lsp('expandMacro'), vim.tbl_extend('force', opts, { desc = 'Rust: Expand macro' }))
vim.keymap.set('n', '<leader>rh', rust_lsp('openDocs'), vim.tbl_extend('force', opts, { desc = 'Rust: Open docs' }))
