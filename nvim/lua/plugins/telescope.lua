return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- Necesario para compilar el plugin nativo
      },
        'nvim-telescope/telescope-ui-select.nvim',
    },

    config = function()
        vim.keymap.set('n', '<Leader><Space>', ':Telescope find_files<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<Leader>ff', ':Telescope grep_string<CR>', { noremap = true, silent = true })
        require('telescope').setup{
            defaults = {
                file_ignore_patterns = {},
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                    '--glob', '!.git/',
                    '--ignore-file', '.gitignore'
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                }
            }
        }

        require('telescope').load_extension('fzf')
        require("telescope").load_extension("ui-select")
    end,

    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = { prompt_position = "top" },
        },
    },
}
