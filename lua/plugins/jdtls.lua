return {
  -- Only used for its test runner: it parses the JUnit remote protocol off the
  -- socket that vscode.java.test.junit.argument hands out. The LSP client itself
  -- is still started by vim.lsp.enable in lsp-config.lua, not by this plugin.
  "mfussenegger/nvim-jdtls",
  ft = "java",
}
