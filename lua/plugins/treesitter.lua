return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  main = "nvim-treesitter.config",
  opts = {
    ensure_installed = { "lua", "python", "javascript" },
    highlight = { enable = true },
  },
}
