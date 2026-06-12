return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "accept", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
        trigger = { show_on_blocked_trigger_characters = { " ", "\n", "\t", ":" } },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          buffer = { score_offset = -5 },
        },
      },
      snippets = { preset = "default" },
    },
  },
}
