if os.getenv("NVIM_PROFILE") ~= "python" then
  return {}
end

return {
  {
    "Vigemus/iron.nvim",
    config = function()
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    end,
  },
}
