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
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "vimls", "clangd", "html", "cssls", "jdtls" },
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

      --  Java
      local mason_pkgs = vim.fn.stdpath("data") .. "/mason/packages"
      local java_test = mason_pkgs .. "/java-test/extension/server/"

      -- OSGi resolves each bundle as it is installed, so dependencies must be listed
      -- before the bundles that need them. asm 9.9 comes first because java-test 0.43
      -- requires asm [9.9,9.10) while jdtls 1.60 ships 9.10.1; these jars are patched
      -- copies from Maven Central, see ~/.local/share/nvim/jdtls-bundles.
      local bundles = vim.fn.glob(vim.fn.stdpath("data") .. "/jdtls-bundles/*.jar", true, true)
      vim.list_extend(
        bundles,
        vim.fn.glob(mason_pkgs .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true)
      )

      -- Everything in java-test except the two jars that are not OSGi bundles: a
      -- single failure there aborts the whole bundle load. The test plugin goes last
      -- because it Require-Bundles the JUnit runtimes above it.
      local test_plugin = vim.fn.glob(java_test .. "com.microsoft.java.test.plugin-*.jar", true, true)
      for _, jar in ipairs(vim.fn.glob(java_test .. "*.jar", true, true)) do
        local name = vim.fn.fnamemodify(jar, ":t")
        local skip = name:match("^com%.microsoft%.java%.test%.plugin")
          or name == "com.microsoft.java.test.runner-jar-with-dependencies.jar"
          or name == "jacocoagent.jar"
        if not skip then
          table.insert(bundles, jar)
        end
      end
      vim.list_extend(bundles, test_plugin)

      vim.lsp.config("jdtls", {
        capabilities = caps,
        init_options = { bundles = bundles },
        settings = {
          java = {
            saveActions = { organizeImports = true },
            signatureHelp = { enabled = true },
            inlayHints = { parameterNames = { enabled = "all" } },
            configuration = { updateBuildConfiguration = "automatic" },
          },
        },
      })

      vim.lsp.enable({ "lua_ls", "pyright", "vimls", "ts_ls", "clangd", "html", "cssls", "jdtls" })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "gr", function()
        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "qf" then
              vim.api.nvim_win_close(win, false)
              return
            end
          end
        end
        vim.lsp.buf.references()
      end, { desc = "Toggle references" })
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
