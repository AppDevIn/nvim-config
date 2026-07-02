return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
    },
    format_on_save = { lsp_fallback = true },
  },
}
