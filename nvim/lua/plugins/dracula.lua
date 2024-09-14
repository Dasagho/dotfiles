return {
    'Mofiqul/dracula.nvim',
    config = function()
        require('dracula').setup({
            italic_comment = true,     -- Comentarios en cursiva
        })
    end
}
