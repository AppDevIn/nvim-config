local dap = require("dap")

local function jdtls()
  return vim.lsp.get_clients({ name = "jdtls" })[1]
end

local function exec(client, command, arguments)
  local res = client:request_sync("workspace/executeCommand", {
    command = command,
    arguments = arguments,
  }, 15000, 0)
  if not res or res.err then
    vim.notify(command .. " failed: " .. vim.inspect(res and res.err), vim.log.levels.ERROR)
    return nil
  end
  return res.result
end

dap.adapters.java = function(callback)
  local client = jdtls()
  if not client then
    vim.notify("jdtls is not attached to this buffer", vim.log.levels.ERROR)
    return
  end
  client:request("workspace/executeCommand", { command = "vscode.java.startDebugSession" }, function(err, port)
    if err then
      vim.notify("startDebugSession failed: " .. vim.inspect(err), vim.log.levels.ERROR)
      return
    end
    callback({ type = "server", host = "127.0.0.1", port = port })
  end)
end

dap.providers.configs["jdtls"] = function(bufnr)
  if vim.bo[bufnr].filetype ~= "java" then
    return {}
  end
  local client = jdtls()
  if not client then
    return {}
  end

  local configs = {}
  for _, main in ipairs(exec(client, "vscode.java.resolveMainClass") or {}) do
    -- Returns a two element list: { modulepaths, classpaths }.
    local paths = exec(client, "vscode.java.resolveClasspath", { main.mainClass, main.projectName })
    table.insert(configs, {
      type = "java",
      request = "launch",
      name = main.mainClass .. " (" .. main.projectName .. ")",
      mainClass = main.mainClass,
      projectName = main.projectName,
      modulePaths = paths and paths[1] or {},
      classPaths = paths and paths[2] or {},
      console = "integratedTerminal",
    })
  end
  return configs
end

-- Test running goes through nvim-jdtls: vscode.java.test.junit.argument hands back a
-- command line for Eclipse's RemoteTestRunner, which reports results over a socket
-- rather than stdout, and nvim-jdtls is what parses that protocol.
local function java_map(lhs, fn, desc)
  vim.keymap.set("n", lhs, function()
    if vim.bo.filetype ~= "java" then
      return
    end
    require("jdtls")[fn]()
  end, { desc = desc })
end

java_map("<leader>tc", "test_class", "Test class")
java_map("<leader>tm", "test_nearest_method", "Test nearest method")
