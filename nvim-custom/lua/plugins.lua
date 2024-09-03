return {
    -- Lazy.nvim
    { 'folke/lazy.nvim', version = '*' },

    -- Mason para gestionar servidores LSP, linters y más
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    },

    -- LSP Configuración
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig')
        end
    },

    -- Integración de Mason con lspconfig
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = { "pyright", "tsserver" }, -- Servidores a instalar automáticamente
                automatic_installation = true,
            }
        end
    },

    -- Treesitter para resaltar la sintaxis
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', lazy = true },

    -- Telescope para búsquedas avanzadas
    { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, lazy = false },


    -- Cmp
    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        event = 'InsertEnter',  -- Carga nvim-cmp cuando entres en modo de inserción
        dependencies = {
            {
                'hrsh7th/cmp-nvim-lsp',
                lazy = true,
                event = 'InsertEnter',  -- Se carga junto con nvim-cmp
            },
            {
                'hrsh7th/cmp-buffer',
                lazy = true,
                event = 'InsertEnter',  -- Se carga junto con nvim-cmp
            },
            {
                'hrsh7th/cmp-path',
                lazy = true,
                event = 'InsertEnter',  -- Se carga junto con nvim-cmp
            },
            {
                'hrsh7th/cmp-cmdline',
                lazy = true,
                event = { 'CmdlineEnter' },  -- Carga solo cuando entres en la línea de comandos
            },
            {
                'saadparwaiz1/cmp_luasnip',
                lazy = true,
                event = 'InsertEnter',  -- Se carga junto con nvim-cmp
            },
            {
                'L3MON4D3/LuaSnip',
                lazy = true,
                event = 'InsertEnter',  -- Carga LuaSnip cuando entres en modo de inserción
            },
            {
                'onsails/lspkind-nvim',
                lazy = true,
                event = 'InsertEnter',  -- Se carga junto con nvim-cmp
            },
        }
    },


    -- Nvim tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },

    -- which-key
    {
        'folke/which-key.nvim',
        config = function()
            require("which-key").setup {}
        end
    },

    -- gitsigns con Nerd Fonts
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true,
        config = function()
            -- Define los íconos de Nerd Font que desees usar
            local icons = {
                add          = '',  -- Icono para añadir
                change       = '',  -- Icono para cambiar
                delete       = '',  -- Icono para eliminar
                topdelete    = '',  -- Icono para eliminar la parte superior
                changedelete = '',  -- Icono para cambio y eliminación
            }

            require('gitsigns').setup {
                signs = {
                    add          = { text = icons.add },
                    change       = { text = icons.change },
                    delete       = { text = icons.delete },
                    topdelete    = { text = icons.topdelete },
                    changedelete = { text = icons.changedelete },
                },
                current_line_blame = true,  -- Mostrar el blame en la línea actual
                sign_priority = 6,
            }

            -- Establecer los resaltados (highlight groups) usando `vim.api.nvim_set_hl`
            vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })
            vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'DiffChange' })
            vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'DiffDelete' })
            vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'DiffDelete' })
            vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'DiffChange' })
            vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAdd' })
            vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChange' })
            vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDelete' })
            vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitSignsTopdelete' })
            vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitSignsChangedelete' })
            vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'GitSignsAdd' })
            vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'GitSignsChange' })
            vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'GitSignsDelete' })
            vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'GitSignsTopdelete' })
            vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'GitSignsChangedelete' })
        end
    },

    -- Tema Catppuccin
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = "mocha", -- Opciones: latte, frappe, macchiato, mocha
                transparent_background = false, -- Si deseas un fondo transparente
                term_colors = true, -- Si deseas que los colores del terminal se integren
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                },
                integrations = {
                    -- Aquí puedes agregar integraciones con otros plugins
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    -- Añade otras integraciones si las usas
                },
            })

            -- Activar el esquema de color
            vim.cmd.colorscheme "catppuccin"
        end
    },

    -- Plugin null-ls
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Integración de Mason y null-ls
    {
        'jay-babu/mason-null-ls.nvim',
        dependencies = { 'williamboman/mason.nvim', 'jose-elias-alvarez/null-ls.nvim' },
        config = function()
            require("mason").setup()
            require("mason-null-ls").setup({
                ensure_installed = {
                    -- Lista de herramientas que quieres que Mason gestione e instale
                    "prettier",  -- Formateador
                    "eslint",    -- Linter
                    -- Agrega más herramientas según necesites
                },
                automatic_installation = true,  -- Instala automáticamente los paquetes configurados
            })

            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- Aquí se integrarán automáticamente las herramientas instaladas por mason-null-ls
                },
                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentFormattingProvider then
                        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
                    end
                end,
            })
        end
    },

    -- Plugin nvim-dap
    { 'mfussenegger/nvim-dap', lazy = true },

    -- Plugin nvim-dap-ui
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, lazy = true },

    -- Plugin mason-nvim-dap para integrar mason con nvim-dap
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
        lazy = true,
        config = function()
            require('mason').setup()

            require('mason-nvim-dap').setup({
                -- Debuggers que deseas instalar automáticamente
                ensure_installed = { "js-debug-adapter" },
                automatic_installation = true,  -- Instala automáticamente los depuradores configurados
                handlers = {},  -- Aquí puedes agregar configuraciones adicionales si es necesario
            })
        end
    },
}
