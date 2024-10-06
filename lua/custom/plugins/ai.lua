return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = {
        enabled = true,
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
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
}
