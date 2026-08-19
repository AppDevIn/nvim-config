local dap = require("dap")

-- Dedicated venv that only exists to host debugpy, so the adapter never depends
-- on whichever python3 happens to win the PATH race (mise shims, /usr/bin, ...).
-- Create it with:
--   python3 -m venv ~/.virtualenvs/debugpy && ~/.virtualenvs/debugpy/bin/python -m pip install debugpy
local debugpy_python = vim.fn.expand("~/.virtualenvs/debugpy/bin/python")

dap.adapters.python = {
  type = "executable",
  command = vim.uv.fs_stat(debugpy_python) and debugpy_python or "python3",
  args = { "-m", "debugpy.adapter" },
}

-- Interpreter used to run the debuggee, independent of the adapter above.
local function python_path()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    return venv .. "/bin/python"
  end

  local cwd = vim.fn.getcwd()
  for _, dir in ipairs({ ".venv", "venv" }) do
    local candidate = cwd .. "/" .. dir .. "/bin/python"
    if vim.uv.fs_stat(candidate) then
      return candidate
    end
  end

  return vim.fn.exepath("python3")
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    console = "integratedTerminal",
    pythonPath = python_path,
  },
}
