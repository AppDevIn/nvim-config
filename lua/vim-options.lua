vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shortmess:append("S")
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true, fg = "#f9e2af" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
