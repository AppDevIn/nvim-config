return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "basedpyright", "ts_ls", "vimls", "clangd" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local caps = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("lua_ls", {
        capabilities = caps,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
      })
      vim.lsp.config("basedpyright", { capabilities = caps })
      vim.lsp.config("clangd", { capabilities = caps })
      vim.lsp.config("vimls", { capabilities = caps })
      vim.lsp.config("ts_ls", { capabilities = caps })
      vim.lsp.enable({ "lua_ls", "basedpyright", "vimls", "ts_ls", "clangd" })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
      end, {})
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
      end, {})
    end,
  },
}
