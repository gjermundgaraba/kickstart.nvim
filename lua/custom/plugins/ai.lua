local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require 'CopilotChat.actions'
    local items = actions[kind .. '_actions']()
    if not items then
      require('noice').notify('No ' .. kind .. ' found on the current line', 'warn')
      return
    end
    local ok = pcall(require, 'fzf-lua')
    require('CopilotChat.integrations.' .. (ok and 'fzflua' or 'telescope')).pick(items)
  end
end

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  { 'AndreM222/copilot-lualine' },
  --   {
  --     {
  --       'yetone/avante.nvim',
  --       event = 'VeryLazy',
  --       lazy = false,
  --       version = false, -- set this if you want to always pull the latest change
  --       opts = {
  --         system_prompt = [[
  -- Act as an expert software developer and Neovim expert (when asked about Vim or Neovim).
  -- Always use best practices when coding.
  -- Respect and use existing conventions, libraries, etc that are already present in the code base.
  -- ]],
  --         provider = 'openai',
  --         openai = {
  --           model = 'o1-mini',
  --         },
  --       },
  --       -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --       build = 'make',
  --       -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --       dependencies = {
  --         'nvim-treesitter/nvim-treesitter',
  --         'stevearc/dressing.nvim',
  --         'nvim-lua/plenary.nvim',
  --         'MunifTanjim/nui.nvim',
  --         --- The below dependencies are optional,
  --         'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
  --         {
  --           -- support for image pasting
  --           'HakonHarnes/img-clip.nvim',
  --           event = 'VeryLazy',
  --           opts = {
  --             -- recommended settings
  --             default = {
  --               embed_image_as_base64 = false,
  --               prompt_for_file_name = false,
  --               drag_and_drop = {
  --                 insert_mode = true,
  --               },
  --               -- required for Windows users
  --               use_absolute_path = true,
  --             },
  --           },
  --         },
  --         {
  --           -- Make sure to set this up properly if you have lazy=true
  --           'MeanderingProgrammer/render-markdown.nvim',
  --           opts = {
  --             file_types = { 'markdown', 'Avante' },
  --           },
  --           ft = { 'markdown', 'Avante' },
  --         },
  --       },
  --     },
  --   },
  --   {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    cmd = 'CopilotChat',
    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        show_help = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require 'CopilotChat.select'
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    keys = {
      { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
      { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input)
          end
        end,
        desc = 'Quick Chat (CopilotChat)',
        mode = { 'n', 'v' },
      },
      -- Show help actions with telescope
      { '<leader>ad', M.pick 'help', desc = 'Diagnostic Help (CopilotChat)', mode = { 'n', 'v' } },
      -- Show prompts actions with telescope
      { '<leader>ap', M.pick 'prompt', desc = 'Prompt Actions (CopilotChat)', mode = { 'n', 'v' } },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      require('CopilotChat.integrations.cmp').setup()

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },

  -- Edgy integration
  {
    'folke/edgy.nvim',
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = 'copilot-chat',
        title = 'Copilot Chat',
        size = { width = 50 },
      })
    end,
  },
}
