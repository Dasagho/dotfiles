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

        map('n', '<leader><Space>', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true, desc = "Find files" })
        map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true, desc = "Find text" })
        map('n', '<leader>ff', '<cmd>Telescope grep_string<CR>', { noremap = true, silent = true, desc = "Grep string" })
        map('n', '<leader>ce', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true, desc = "Find errors" })
        map('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true, desc = "Find references" })
        map('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true, desc = "Find definition" })
        map('n', 'gf', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true, desc = "Go to file" })
        map('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>', { noremap = true, silent = true, desc = "Find implementations" })
        map('n', '<leader>gc', '<cmd>Telescope git_status<CR>', { noremap = true, silent = true, desc = "Git changes" })
        map('n', '<leader>fm', '<cmd>Telescope marks<CR>', { noremap = true, silent = true, desc = "Find marks" })


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
                    '--glob', '!.git/'
                },
                layout_strategy = 'horizontal', -- Usar diseño horizontal
                layout_config = {
                    horizontal = {
                        -- Establece el tamaño total de la ventana de Telescope
                        width = 0.95, -- El 90% del ancho de la pantalla
                        height = 0.95, -- El 80% de la altura de la pantalla
                        preview_cutoff = 120, -- Si la ventana es más pequeña que esto, no se muestra la previsualización
                        -- Ajusta el ancho relativo de la previsualización y la lista de archivos
                        preview_width = 0.7, -- La previsualización ocupará el 60% del ancho de la ventana
                    },
                },
            },

            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                },
            }
        }

        require('telescope').load_extension('fzf')
        require('telescope').load_extension('ui-select')
    end,

    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = { prompt_position = "top" },
        },
    },
}
