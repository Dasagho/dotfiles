return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  config = function()
    -- Asegúrate de tener fidget.nvim instalado
    require("fidget").setup {}
  end,
}
