return {
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    config = function()
      require("neopywal").setup()
      vim.cmd("colorscheme neopywal")
    end,
  },
}
