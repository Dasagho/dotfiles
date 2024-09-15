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
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        map('n', '<Leader><Space>', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true, desc = "Find files" })
        map('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true, desc = "Find text" })
        map('n', '<Leader>ff', '<cmd>Telescope grep_string<CR>', { noremap = true, silent = true, desc = "Grep string" })
        map('n', '<leader>ce', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true, desc = "Find errors" })
        map('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true, desc = "Find references" })
        map('n', '<leader>fd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true, desc = "Find definition" })
        map('n', '<leader>fi', '<cmd>Telescope lsp_implementations<CR>', { noremap = true, silent = true, desc = "Find implementations" })

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
                    '--hidden',  -- Sigue buscando archivos ocultos
                    '--glob', '!.git/',  -- Excluye el directorio .git
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
