if vim.g.colors_name then
  vim.cmd("hi clear")
end
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "custom"

local c = {
  bg = "#111421",
  bg_alt = "#171b2c",
  bg_highlight = "#232842",
  bg_visual = "#2a3050",
  fg = "#c7cce0",
  fg_dim = "#4b5375",
  comment = "#5c6791",
  pink = "#ee7b8c",
  yellow = "#e5ce72",
  teal = "#70e9db",
  blue = "#7fc1fa",
  green = "#78e98f",
  orange = "#f19a67",
  red = "#f28b82",
  none = "NONE",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor UI
hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg_alt })
hl("FloatBorder", { fg = c.fg_dim, bg = c.bg_alt })
hl("FloatTitle", { fg = c.blue, bg = c.bg_alt })
hl("Cursor", { fg = c.bg, bg = c.fg })
hl("CursorLine", { bg = c.bg_alt })
hl("CursorLineNr", { fg = c.yellow, bold = true })
hl("LineNr", { fg = c.fg_dim })
hl("SignColumn", { bg = c.bg })
hl("ColorColumn", { bg = c.bg_alt })
hl("Visual", { bg = c.bg_visual })
hl("VisualNOS", { bg = c.bg_visual })
hl("Search", { fg = c.bg, bg = c.yellow })
hl("IncSearch", { fg = c.bg, bg = c.orange })
hl("CurSearch", { fg = c.bg, bg = c.orange })
hl("Pmenu", { fg = c.fg, bg = c.bg_alt })
hl("PmenuSel", { fg = c.bg, bg = c.blue })
hl("PmenuSbar", { bg = c.bg_alt })
hl("PmenuThumb", { bg = c.fg_dim })
hl("StatusLine", { fg = c.fg, bg = c.bg_alt })
hl("StatusLineNC", { fg = c.fg_dim, bg = c.bg_alt })
hl("WinSeparator", { fg = c.bg_highlight })
hl("VertSplit", { fg = c.bg_highlight })
hl("TabLine", { fg = c.fg_dim, bg = c.bg_alt })
hl("TabLineSel", { fg = c.fg, bg = c.bg_highlight })
hl("TabLineFill", { bg = c.bg })
hl("MatchParen", { fg = c.orange, bold = true })
hl("NonText", { fg = c.fg_dim })
hl("Whitespace", { fg = c.bg_highlight })
hl("EndOfBuffer", { fg = c.bg })
hl("Folded", { fg = c.comment, bg = c.bg_alt })
hl("Directory", { fg = c.blue })
hl("Title", { fg = c.blue, bold = true })
hl("ModeMsg", { fg = c.fg })
hl("MoreMsg", { fg = c.green })
hl("Question", { fg = c.green })
hl("WarningMsg", { fg = c.yellow })
hl("ErrorMsg", { fg = c.red })
hl("WildMenu", { fg = c.bg, bg = c.blue })

-- Diagnostics
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.teal })
hl("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = c.yellow, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = c.blue, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = c.teal, undercurl = true })

-- Diff
hl("DiffAdd", { fg = c.green, bg = c.none })
hl("DiffChange", { fg = c.yellow, bg = c.none })
hl("DiffDelete", { fg = c.red, bg = c.none })
hl("DiffText", { fg = c.blue, bg = c.none })

-- Git signs
hl("GitSignsAdd", { fg = c.green })
hl("GitSignsChange", { fg = c.yellow })
hl("GitSignsDelete", { fg = c.red })

-- Base syntax
hl("Comment", { fg = c.comment, italic = true })
hl("String", { fg = c.teal })
hl("Character", { fg = c.teal })
hl("Number", { fg = c.orange })
hl("Float", { fg = c.orange })
hl("Boolean", { fg = c.orange })
hl("Constant", { fg = c.orange })
hl("Identifier", { fg = c.pink })
hl("Function", { fg = c.green })
hl("Statement", { fg = c.yellow })
hl("Conditional", { fg = c.yellow })
hl("Repeat", { fg = c.yellow })
hl("Label", { fg = c.yellow })
hl("Operator", { fg = c.orange })
hl("Keyword", { fg = c.teal })
hl("Exception", { fg = c.yellow })
hl("PreProc", { fg = c.yellow })
hl("Include", { fg = c.yellow })
hl("Define", { fg = c.yellow })
hl("Macro", { fg = c.yellow })
hl("Type", { fg = c.blue })
hl("StorageClass", { fg = c.teal })
hl("Structure", { fg = c.blue })
hl("Typedef", { fg = c.blue })
hl("Special", { fg = c.orange })
hl("SpecialChar", { fg = c.orange })
hl("Delimiter", { fg = c.yellow })
hl("Tag", { fg = c.pink })
hl("Underlined", { fg = c.blue, underline = true })
hl("Todo", { fg = c.bg, bg = c.yellow, bold = true })
hl("Error", { fg = c.red })

-- Treesitter
hl("@comment", { link = "Comment" })
hl("@string", { link = "String" })
hl("@string.escape", { fg = c.orange })
hl("@number", { link = "Number" })
hl("@number.float", { link = "Float" })
hl("@boolean", { link = "Boolean" })
hl("@constant", { fg = c.orange })
hl("@constant.builtin", { fg = c.orange })
hl("@variable", { fg = c.pink })
hl("@variable.builtin", { fg = c.blue })
hl("@variable.parameter", { fg = c.pink, italic = true })
hl("@variable.member", { fg = c.green })
hl("@property", { fg = c.green })
hl("@field", { fg = c.green })
hl("@function", { link = "Function" })
hl("@function.call", { link = "Function" })
hl("@function.builtin", { fg = c.green })
hl("@function.method", { link = "Function" })
hl("@function.method.call", { link = "Function" })
hl("@constructor", { fg = c.yellow })
hl("@module", { fg = c.blue })
hl("@namespace", { fg = c.blue })
hl("@keyword", { fg = c.teal })
hl("@keyword.function", { fg = c.teal })
hl("@keyword.operator", { fg = c.yellow })
hl("@keyword.conditional", { fg = c.yellow })
hl("@keyword.repeat", { fg = c.yellow })
hl("@keyword.return", { fg = c.yellow })
hl("@keyword.import", { fg = c.yellow })
hl("@keyword.coroutine", { fg = c.yellow })
hl("@keyword.exception", { fg = c.yellow })
hl("@operator", { fg = c.orange })
hl("@punctuation.delimiter", { fg = c.yellow })
hl("@punctuation.bracket", { fg = c.yellow })
hl("@punctuation.special", { fg = c.yellow })
hl("@type", { fg = c.blue })
hl("@type.builtin", { fg = c.blue })
hl("@tag", { fg = c.pink })
hl("@tag.attribute", { fg = c.green })
hl("@tag.delimiter", { fg = c.yellow })
hl("@markup.italic", { fg = c.fg, italic = true })
hl("@markup.strong", { fg = c.fg, bold = true })
hl("@markup.heading", { fg = c.blue, bold = true })
hl("@markup.link.url", { fg = c.blue, underline = true })

-- LSP semantic tokens
hl("@lsp.type.namespace", { fg = c.blue })
hl("@lsp.type.type", { fg = c.blue })
hl("@lsp.type.class", { fg = c.blue })
hl("@lsp.type.enum", { fg = c.blue })
hl("@lsp.type.interface", { fg = c.blue })
hl("@lsp.type.struct", { fg = c.blue })
hl("@lsp.type.parameter", { fg = c.pink, italic = true })
hl("@lsp.type.variable", { fg = c.pink })
hl("@lsp.type.property", { fg = c.green })
hl("@lsp.type.function", { fg = c.green })
hl("@lsp.type.method", { fg = c.green })
hl("@lsp.type.keyword", { fg = c.teal })
hl("@lsp.typemod.variable.defaultLibrary", { fg = c.blue })
hl("@lsp.typemod.variable.readonly", { fg = c.pink })
hl("@lsp.typemod.function.defaultLibrary", { fg = c.green })

-- Plugin: nvim-cmp / blink.cmp
hl("CmpItemAbbrMatch", { fg = c.blue, bold = true })
hl("CmpItemKindFunction", { fg = c.green })
hl("CmpItemKindVariable", { fg = c.pink })
hl("CmpItemKindKeyword", { fg = c.teal })

-- Plugin: Telescope
hl("TelescopeSelection", { bg = c.bg_alt })
hl("TelescopeMatching", { fg = c.orange, bold = true })
hl("TelescopeBorder", { fg = c.fg_dim })
hl("TelescopePromptBorder", { fg = c.fg_dim })

-- Plugin: neo-tree / nvim-tree
hl("NeoTreeDirectoryIcon", { fg = c.blue })
hl("NeoTreeDirectoryName", { fg = c.blue })
hl("NeoTreeRootName", { fg = c.blue, bold = true })

-- Plugin: WhichKey
hl("WhichKey", { fg = c.blue })
hl("WhichKeyGroup", { fg = c.yellow })
hl("WhichKeyDesc", { fg = c.fg })
