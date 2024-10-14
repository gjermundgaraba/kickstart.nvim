-- More general utility plugins

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = true,
      },
      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]ests' },
      },
    },
  },
  { -- Terminal
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    -- stylua: ignore
    keys = {
      { "<C-h>", "<cmd>wincmd h<CR>", mode = "t" },
      { "<C-j>", "<cmd>wincmd j<CR>", mode = "t" },
      { "<C-k>", "<cmd>wincmd k<CR>", mode = "t" },
      { "<C-l>", "<cmd>wincmd l<CR>", mode = "t" },
      { "<esc>", "<C-\\><C-n>", mode = "t" },
    },
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<D-T>]],
        insert_mappings = true,
        start_in_insert = true,
        autochdir = true,
      }

      local augroup_term_insert = vim.api.nvim_create_augroup('Term-Insert', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter', 'TermOpen', 'TermEnter' }, {
        group = augroup_term_insert,
        pattern = 'term://*',
        command = 'startinsert',
      })
    end,
  },
}
