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
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "vimls", "clangd", "html", "cssls" },
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
      vim.lsp.config("pyright", { capabilities = caps })
      vim.lsp.config("clangd", { capabilities = caps })
      vim.lsp.config("vimls", { capabilities = caps })
      vim.lsp.config("ts_ls", { capabilities = caps })
      vim.lsp.config("html", { capabilities = caps })
      vim.lsp.config("cssls", { capabilities = caps })
      vim.lsp.enable({ "lua_ls", "pyright", "vimls", "ts_ls", "clangd", "html", "cssls" })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
      end, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
      end, { desc = "Next diagnostic" })
    end,
  },
}
