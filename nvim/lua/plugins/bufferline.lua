return {
    "akinsho/bufferline.nvim",
    event = "BufReadPre",
    options = {
        themable = true,
        offsets = {
            {
                filetype = "NvimTree",
                highlight = "NvimTreeNormal",
            },
        },
    },
}
