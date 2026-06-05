return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<S-Tab>"] = { "accept", "fallback" },
        ["<CR>"] = { "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = true } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
}
