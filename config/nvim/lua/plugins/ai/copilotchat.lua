---@type LazyPluginSpec
return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    cmd = {
      'CopilotChat',
      'CopilotChatExplain',
      'CopilotChatReview',
      'CopilotChatFix',
      'CopilotChatOptimize',
      'CopilotChatDocs',
      'CopilotChatTests',
    },
    opts = {
      -- See Configuration section for options
      -- debug = true,
    },
    -- See Commands section for default commands if you want to lazy load on them
    config = function()
      vim.env.GITHUB_ENTERPRISE_URL = 'https://etraid.ghe.com'

      require('CopilotChat').setup {
        -- debug = true,
        -- show_help = true,
        url = 'https://etraid.ghe.com',

        prompts = {
          Explain = {
            prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
          },
          Review = {
            prompt = '/COPILOT_REVIEW Review the selected code.',
          },
          Fix = {
            prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
          },
          Optimize = {
            prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readability.',
          },
          Docs = {
            prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
          },
          Tests = {
            prompt = '/COPILOT_GENERATE Please generate tests for my code.',
          },
        },

        window = {
          layout = 'vertical',
          width = 0.5,
          height = 0.5,
          relative = 'editor',
        },
      }
    end,
  },
}
