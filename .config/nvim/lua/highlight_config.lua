local M = {}

---@param colors ZlColors
function M.setup(colors)
  local function set(group_id, group_name, opts)
    vim.api.nvim_set_hl(group_id, group_name, opts)
  end

  -- =========================================================
  -- CORE EDITOR
  -- =========================================================
  set(0, "Normal", { fg = colors.fg_primary, bg = "NONE" })
  set(0, "NormalNC", { fg = colors.text_muted, bg = "NONE" })
  set(0, "EndOfBuffer", { fg = colors.text_faint, bg = "NONE" })
  set(0, "LineNr", { fg = colors.text_faint, bg = "NONE" })
  set(0, "CursorLineNr", { fg = colors.fg_secondary, bold = true })
  set(0, "CursorLine", { bg = "NONE" })
  set(0, "CursorColumn", { bg = "NONE" })
  set(0, "ColorColumn", { bg = "NONE" })
  set(0, "SignColumn", { bg = "NONE" })
  set(0, "Whitespace", { fg = colors.bg_tertiary })
  set(0, "NonText", { fg = colors.text_faint })
  set(0, "SpecialKey", { fg = colors.text_faint })
  set(0, "Conceal", { fg = colors.info })
  set(0, "Directory", { fg = colors.info, bold = true })
  set(0, "Title", { fg = colors.accent_tertiary, bold = true })
  set(0, "YankedText", { fg = colors.bg_primary, bg = colors.hint })

  -- =========================================================
  -- CURSOR
  -- =========================================================
  set(0, "Cursor", { fg = colors.bg_primary, bg = colors.fg_primary })
  set(0, "lCursor", { fg = colors.bg_primary, bg = colors.fg_primary })
  set(0, "CursorIM", { fg = colors.bg_primary, bg = colors.fg_primary })
  set(0, "TermCursor", { fg = colors.bg_primary, bg = colors.fg_primary })
  set(0, "TermCursorNC", { fg = colors.bg_primary, bg = colors.text_faint })

  -- =========================================================
  -- VISUAL / SEARCH / MATCH
  -- =========================================================
  set(0, "Visual", { bg = colors.bg_tertiary })
  set(0, "VisualNOS", { bg = colors.bg_tertiary })
  set(0, "Search", { fg = colors.bg_primary, bg = colors.accent_tertiary })
  set(0, "IncSearch", { fg = colors.bg_primary, bg = colors.warning, bold = true })
  set(0, "CurSearch", { fg = colors.bg_primary, bg = colors.error, bold = true })
  set(0, "Substitute", { fg = colors.bg_primary, bg = colors.warning })
  set(0, "MatchParen", { fg = colors.warning, bold = true })

  -- =========================================================
  -- FLOATING WINDOWS / PMENU
  -- =========================================================
  set(0, "NormalFloat", { fg = colors.fg_primary, bg = colors.bg_secondary })
  set(0, "FloatBorder", { fg = colors.text_faint, bg = "NONE" })
  set(0, "FloatTitle", { fg = colors.accent_tertiary, bg = "NONE", bold = true })
  set(0, "FloatFooter", { fg = colors.text_faint, bg = "NONE" })
  set(0, "Pmenu", { fg = colors.fg_primary, bg = "NONE" })
  set(0, "PmenuSel", { fg = colors.bg_primary, bg = colors.hint, bold = true })
  set(0, "PmenuBorder", { fg = colors.text_faint, bg = "NONE" })
  set(0, "PmenuSbar", { bg = colors.bg_secondary })
  set(0, "PmenuThumb", { bg = colors.text_faint })
  set(0, "PmenuKind", { fg = colors.accent_primary, bg = colors.bg_secondary })
  set(0, "PmenuKindSel", { fg = colors.bg_primary, bg = colors.hint, bold = true })
  set(0, "PmenuExtra", { fg = colors.text_muted, bg = colors.bg_secondary })
  set(0, "PmenuExtraSel", { fg = colors.bg_primary, bg = colors.hint })

  -- =========================================================
  -- MESSAGES / COMMAND LINE
  -- =========================================================
  set(0, "MsgArea", { fg = colors.fg_primary })
  set(0, "MsgSeparator", { fg = colors.text_faint, bg = colors.bg_secondary })
  set(0, "MoreMsg", { fg = colors.hint, bold = true })
  set(0, "Question", { fg = colors.accent_tertiary, bold = true })
  set(0, "WarningMsg", { fg = colors.warning, bold = true })
  set(0, "ErrorMsg", { fg = colors.error, bold = true })
  set(0, "ModeMsg", { fg = colors.fg_secondary, bold = true })

  -- =========================================================
  -- DIAGNOSTICS
  -- =========================================================
  set(0, "DiagnosticError", { fg = colors.error })
  set(0, "DiagnosticWarn", { fg = colors.warning })
  set(0, "DiagnosticInfo", { fg = colors.info })
  set(0, "DiagnosticHint", { fg = colors.hint })
  set(0, "DiagnosticOk", { fg = colors.accent_secondary })
  set(0, "DiagnosticUnderlineError", { sp = colors.error, undercurl = true })
  set(0, "DiagnosticUnderlineWarn", { sp = colors.warning, undercurl = true })
  set(0, "DiagnosticUnderlineInfo", { sp = colors.info, undercurl = true })
  set(0, "DiagnosticUnderlineHint", { sp = colors.hint, undercurl = true })
  set(0, "DiagnosticUnderlineOk", { sp = colors.accent_secondary, undercurl = true })
  set(0, "DiagnosticVirtualTextError", { fg = colors.error, bg = colors.bg_primary })
  set(0, "DiagnosticVirtualTextWarn", { fg = colors.warning, bg = colors.bg_primary })
  set(0, "DiagnosticVirtualTextInfo", { fg = colors.info, bg = colors.bg_primary })
  set(0, "DiagnosticVirtualTextHint", { fg = colors.hint, bg = colors.bg_primary })
  set(0, "DiagnosticSignError", { fg = colors.error })
  set(0, "DiagnosticSignWarn", { fg = colors.warning })
  set(0, "DiagnosticSignInfo", { fg = colors.info })
  set(0, "DiagnosticSignHint", { fg = colors.hint })

  -- =========================================================
  -- SPLITS / BORDERS
  -- =========================================================
  set(0, "WinSeparator", { fg = colors.bg_tertiary })
  set(0, "VertSplit", { fg = colors.bg_tertiary })

  -- =========================================================
  -- STATUS LINE
  -- =========================================================
  set(0, "StatusLine", { fg = colors.text_muted, bg = "NONE" })
  set(0, "StatusLineNC", { fg = colors.text_faint, bg = colors.bg_primary })

  -- =========================================================
  -- TABLINE
  -- =========================================================
  set(0, "TabLine", { fg = colors.text_faint, bg = colors.bg_primary })
  set(0, "TabLineFill", { bg = colors.bg_primary })
  set(0, "TabLineSel", { fg = colors.accent_primary, bg = colors.bg_secondary, bold = true })

  -- =========================================================
  -- SPELL CHECKING
  -- =========================================================
  set(0, "SpellBad", { sp = colors.error, undercurl = true })
  set(0, "SpellCap", { sp = colors.info, undercurl = true })
  set(0, "SpellLocal", { sp = colors.accent_secondary, undercurl = true })
  set(0, "SpellRare", { sp = colors.accent_primary, undercurl = true })

  -- =========================================================
  -- DIFF
  -- =========================================================
  set(0, "DiffAdd", { fg = colors.hint, bg = colors.bg_primary })
  set(0, "DiffChange", { fg = colors.info, bg = colors.bg_primary })
  set(0, "DiffDelete", { fg = colors.error, bg = colors.bg_primary })
  set(0, "DiffText", { fg = colors.accent_tertiary, bg = colors.bg_primary, bold = true })
  set(0, "diffAdded", { fg = colors.hint })
  set(0, "diffRemoved", { fg = colors.error })
  set(0, "diffChanged", { fg = colors.info })
  set(0, "diffFile", { fg = colors.warning })
  set(0, "diffNewFile", { fg = colors.accent_tertiary })
  set(0, "diffLine", { fg = colors.accent_secondary })

  -- =========================================================
  -- FOLDING
  -- =========================================================
  set(0, "Folded", { fg = colors.text_faint, bg = colors.bg_primary, italic = true })
  set(0, "FoldColumn", { fg = colors.text_faint, bg = "NONE" })

  -- =========================================================
  -- QUICKFIX / LOCATION LIST
  -- =========================================================
  set(0, "QuickFixLine", { bg = colors.bg_tertiary, bold = true })
  set(0, "qfLineNr", { fg = colors.accent_tertiary })
  set(0, "qfFileName", { fg = colors.info })

  -- =========================================================
  -- WILDMENU
  -- =========================================================
  set(0, "WildMenu", { fg = colors.bg_primary, bg = colors.info, bold = true })

  -- =========================================================
  -- SYNTAX - BASE GROUPS
  -- =========================================================
  -- Keywords and control flow
  set(0, "Keyword", { fg = colors.info, italic = true })
  set(0, "Statement", { fg = colors.info, italic = true })
  set(0, "Conditional", { fg = colors.info, italic = true })
  set(0, "Repeat", { fg = colors.info, italic = true })
  set(0, "Label", { fg = colors.info, italic = true })
  set(0, "Exception", { fg = colors.info, italic = true })
  set(0, "Include", { fg = colors.info, italic = true })
  set(0, "Define", { fg = colors.info, italic = true })
  set(0, "Macro", { fg = colors.accent_secondary })
  set(0, "PreProc", { fg = colors.accent_secondary })
  set(0, "PreCondit", { fg = colors.accent_secondary })

  -- Types and structures
  set(0, "Type", { fg = colors.accent_tertiary })
  set(0, "StorageClass", { fg = colors.warning })
  set(0, "Structure", { fg = colors.accent_secondary })
  set(0, "Typedef", { fg = colors.accent_tertiary })

  -- Functions and methods
  set(0, "Function", { fg = colors.accent_primary })

  -- Variables and identifiers
  set(0, "Identifier", { fg = colors.fg_primary })

  -- Constants and literals
  set(0, "Constant", { fg = colors.fg_secondary })
  set(0, "Boolean", { fg = colors.accent_primary })
  set(0, "Number", { fg = colors.warning })
  set(0, "Float", { fg = colors.warning })
  set(0, "String", { fg = colors.hint })
  set(0, "Character", { fg = colors.hint })

  -- Operators and delimiters
  set(0, "Operator", { fg = colors.text_muted })
  set(0, "Delimiter", { fg = colors.text_muted })

  -- Special elements
  set(0, "Special", { fg = colors.warning })
  set(0, "SpecialChar", { fg = colors.text_muted })
  set(0, "SpecialComment", { fg = colors.text_faint, italic = true })
  set(0, "Tag", { fg = colors.accent_secondary })
  set(0, "Debug", { fg = colors.error })

  -- Comments and annotations
  set(0, "Comment", { fg = colors.text_faint, italic = true })
  set(0, "Todo", { fg = colors.accent_tertiary, bold = true })
  set(0, "Note", { fg = colors.info, bold = true })
  set(0, "Error", { fg = colors.error, bold = true })
  set(0, "Warning", { fg = colors.warning, bold = true })

  -- Underlined and markup
  set(0, "Underlined", { fg = colors.info, underline = true })
  set(0, "Ignore", { fg = colors.text_faint })

  -- =========================================================
  -- TREESITTER - CORE LINKS
  -- =========================================================
  -- Keywords
  set(0, "@keyword", { link = "Keyword" })
  set(0, "@keyword.function", { link = "Keyword" })
  set(0, "@keyword.operator", { link = "Keyword" })
  set(0, "@keyword.return", { link = "Keyword" })
  set(0, "@keyword.conditional", { link = "Conditional" })
  set(0, "@keyword.repeat", { link = "Repeat" })
  set(0, "@keyword.exception", { link = "Exception" })
  set(0, "@keyword.import", { link = "Include" })

  -- Functions
  set(0, "@function", { link = "Function" })
  set(0, "@function.builtin", { link = "Function" })
  set(0, "@function.call", { link = "Function" })
  set(0, "@function.macro", { link = "Macro" })
  set(0, "@method", { link = "Function" })
  set(0, "@method.call", { link = "Function" })
  set(0, "@constructor", { fg = colors.accent_tertiary })

  -- Variables
  set(0, "@variable", { link = "Identifier" })
  set(0, "@variable.builtin", { fg = colors.warning })
  set(0, "@variable.parameter", { fg = colors.fg_secondary })
  set(0, "@variable.member", { fg = colors.fg_secondary })
  set(0, "@property", { fg = colors.fg_secondary })
  set(0, "@field", { fg = colors.fg_secondary })

  -- Constants
  set(0, "@constant", { link = "Constant" })
  set(0, "@constant.builtin", { link = "Constant" })
  set(0, "@constant.macro", { link = "Macro" })

  -- Types
  set(0, "@type", { link = "Type" })
  set(0, "@type.builtin", { link = "Type" })
  set(0, "@type.definition", { link = "Typedef" })
  set(0, "@type.qualifier", { link = "StorageClass" })
  set(0, "@storageclass", { link = "StorageClass" })
  set(0, "@namespace", { fg = colors.accent_secondary })
  set(0, "@module", { fg = colors.accent_secondary })

  -- Literals
  set(0, "@string", { link = "String" })
  set(0, "@string.regex", { fg = colors.warning })
  set(0, "@string.escape", { fg = colors.error })
  set(0, "@string.special", { link = "SpecialChar" })
  set(0, "@character", { link = "Character" })
  set(0, "@character.special", { link = "SpecialChar" })
  set(0, "@number", { link = "Number" })
  set(0, "@number.float", { link = "Float" })
  set(0, "@boolean", { link = "Boolean" })

  -- Operators
  set(0, "@operator", { link = "Operator" })

  -- Punctuation
  set(0, "@punctuation", { link = "Delimiter" })
  set(0, "@punctuation.delimiter", { link = "Delimiter" })
  set(0, "@punctuation.bracket", { link = "Delimiter" })
  set(0, "@punctuation.special", { fg = colors.warning })

  -- Comments
  set(0, "@comment", { link = "Comment" })
  set(0, "@comment.documentation", { fg = colors.text_muted, italic = true })
  set(0, "@comment.error", { fg = colors.error, bold = true })
  set(0, "@comment.warning", { fg = colors.warning, bold = true })
  set(0, "@comment.note", { fg = colors.info, bold = true })
  set(0, "@comment.todo", { link = "Todo" })

  -- Labels and tags
  set(0, "@label", { link = "Label" })
  set(0, "@tag", { link = "Tag" })
  set(0, "@tag.attribute", { fg = colors.accent_secondary })
  set(0, "@tag.delimiter", { link = "Delimiter" })

  -- Markup (Markdown, etc)
  set(0, "@markup.strong", { bold = true })
  set(0, "@markup.italic", { italic = true })
  set(0, "@markup.underline", { underline = true })
  set(0, "@markup.strikethrough", { strikethrough = true })
  set(0, "@markup.heading", { fg = colors.accent_tertiary, bold = true })
  set(0, "@markup.heading.1", { fg = colors.error, bold = true })
  set(0, "@markup.heading.2", { fg = colors.warning, bold = true })
  set(0, "@markup.heading.3", { fg = colors.accent_tertiary, bold = true })
  set(0, "@markup.heading.4", { fg = colors.hint, bold = true })
  set(0, "@markup.heading.5", { fg = colors.info, bold = true })
  set(0, "@markup.heading.6", { fg = colors.accent_primary, bold = true })
  set(0, "@markup.quote", { fg = colors.text_muted, italic = true })
  set(0, "@markup.math", { fg = colors.info })
  set(0, "@markup.link", { fg = colors.info, underline = true })
  set(0, "@markup.link.label", { fg = colors.accent_secondary })
  set(0, "@markup.link.url", { fg = colors.info, underline = true })
  set(0, "@markup.raw", { fg = colors.hint })
  set(0, "@markup.raw.block", { fg = colors.hint })
  set(0, "@markup.list", { fg = colors.warning })
  set(0, "@markup.list.checked", { fg = colors.hint })
  set(0, "@markup.list.unchecked", { fg = colors.text_faint })

  -- Diff
  set(0, "@diff.plus", { link = "DiffAdd" })
  set(0, "@diff.minus", { link = "DiffDelete" })
  set(0, "@diff.delta", { link = "DiffChange" })

  -- Special
  set(0, "@text.emphasis", { italic = true })
  set(0, "@text.strong", { bold = true })
  set(0, "@text.strike", { strikethrough = true })
  set(0, "@text.underline", { underline = true })
  set(0, "@text.title", { link = "Title" })
  set(0, "@text.literal", { fg = colors.hint })
  set(0, "@text.uri", { fg = colors.info, underline = true })
  set(0, "@text.reference", { fg = colors.accent_secondary })

  -- =========================================================
  -- LSP SEMANTIC TOKENS
  -- =========================================================
  set(0, "@lsp.type.class", { link = "Type" })
  set(0, "@lsp.type.decorator", { link = "Function" })
  set(0, "@lsp.type.enum", { link = "Type" })
  set(0, "@lsp.type.enumMember", { link = "Constant" })
  set(0, "@lsp.type.function", { link = "Function" })
  set(0, "@lsp.type.interface", { link = "Type" })
  set(0, "@lsp.type.macro", { link = "Macro" })
  set(0, "@lsp.type.method", { link = "Function" })
  set(0, "@lsp.type.namespace", { link = "@namespace" })
  set(0, "@lsp.type.parameter", { link = "@variable.parameter" })
  set(0, "@lsp.type.property", { link = "@property" })
  set(0, "@lsp.type.struct", { link = "Type" })
  set(0, "@lsp.type.type", { link = "Type" })
  set(0, "@lsp.type.typeParameter", { link = "Type" })
  set(0, "@lsp.type.variable", { link = "@variable" })

  -- =========================================================
  -- GIT SIGNS
  -- =========================================================
  set(0, "GitSignsAdd", { fg = colors.hint })
  set(0, "GitSignsChange", { fg = colors.info })
  set(0, "GitSignsDelete", { fg = colors.error })
  set(0, "GitSignsAddLn", { fg = colors.hint, bg = colors.bg_primary })
  set(0, "GitSignsChangeLn", { fg = colors.info, bg = colors.bg_primary })
  set(0, "GitSignsDeleteLn", { fg = colors.error, bg = colors.bg_primary })

  -- =========================================================
  -- TELESCOPE
  -- =========================================================
  set(0, "TelescopeBorder", { fg = colors.text_faint, bg = colors.bg_primary })
  set(0, "TelescopePromptBorder", { fg = colors.text_faint, bg = colors.bg_primary })
  set(0, "TelescopeResultsBorder", { fg = colors.text_faint, bg = colors.bg_primary })
  set(0, "TelescopePreviewBorder", { fg = colors.text_faint, bg = colors.bg_primary })
  set(0, "TelescopeSelection", { fg = colors.fg_secondary, bg = colors.bg_tertiary, bold = true })
  set(0, "TelescopeSelectionCaret", { fg = colors.warning, bg = colors.bg_tertiary })
  set(0, "TelescopeMultiSelection", { fg = colors.accent_primary, bg = colors.bg_tertiary })
  set(0, "TelescopeNormal", { fg = colors.fg_primary, bg = colors.bg_primary })
  set(0, "TelescopeMatching", { fg = colors.accent_tertiary, bold = true })
  set(0, "TelescopePromptPrefix", { fg = colors.info, bold = true })
  set(0, "TelescopeTitle", { fg = colors.accent_tertiary, bold = true })

  -- =========================================================
  -- INDENT BLANKLINE
  -- =========================================================
  set(0, "IndentBlanklineChar", { fg = colors.bg_tertiary })
  set(0, "IndentBlanklineContextChar", { fg = colors.text_faint })
  set(0, "IndentBlanklineContextStart", { sp = colors.text_faint, underline = true })

  -- =========================================================
  -- NOTIFY
  -- =========================================================
  set(0, "NotifyERRORTitle", { fg = colors.error, bold = true })
  set(0, "NotifyERRORIcon", { fg = colors.error })
  set(0, "NotifyERRORBody", { fg = colors.fg_primary, bg = "NONE" })
  set(0, "NotifyERRORBorder", { fg = colors.error, bg = colors.bg_primary })

  set(0, "NotifyWARNTitle", { fg = colors.warning, bold = true })
  set(0, "NotifyWARNIcon", { fg = colors.warning })
  set(0, "NotifyWARNBody", { fg = colors.fg_primary, bg = "NONE" })
  set(0, "NotifyWARNBorder", { fg = colors.warning, bg = colors.bg_primary })

  set(0, "NotifyINFOTitle", { fg = colors.info, bold = true })
  set(0, "NotifyINFOIcon", { fg = colors.info })
  set(0, "NotifyINFOBody", { fg = colors.fg_primary, bg = "NONE" })
  set(0, "NotifyINFOBorder", { fg = colors.info, bg = colors.bg_primary })

  set(0, "NotifyDEBUGTitle", { fg = colors.text_faint, bold = true })
  set(0, "NotifyDEBUGIcon", { fg = colors.text_faint })
  set(0, "NotifyDEBUGBody", { fg = colors.fg_primary, bg = "NONE" })
  set(0, "NotifyDEBUGBorder", { fg = colors.text_faint, bg = colors.bg_primary })

  set(0, "NotifyTRACETitle", { fg = colors.accent_primary, bold = true })
  set(0, "NotifyTRACEIcon", { fg = colors.accent_primary })
  set(0, "NotifyTRACEBody", { fg = colors.fg_primary, bg = "NONE" })
  set(0, "NotifyTRACEBorder", { fg = colors.accent_primary, bg = colors.bg_primary })

  set(0, "NotifyBackground", { bg = "NONE" })

  -- =========================================================
  -- CMP
  -- =========================================================
  set(0, "CmpItemAbbrMatch", { fg = colors.accent_tertiary, bold = true })
  set(0, "CmpItemAbbrMatchFuzzy", { fg = colors.accent_tertiary })
  set(0, "CmpItemKindVariable", { fg = colors.fg_primary })
  set(0, "CmpItemKindInterface", { fg = colors.accent_tertiary })
  set(0, "CmpItemKindText", { fg = colors.fg_primary })
  set(0, "CmpItemKindFunction", { fg = colors.accent_primary })
  set(0, "CmpItemKindMethod", { fg = colors.accent_primary })
  set(0, "CmpItemKindKeyword", { fg = colors.info })
  set(0, "CmpItemKindProperty", { fg = colors.fg_secondary })
  set(0, "CmpItemKindUnit", { fg = colors.warning })
  set(0, "CmpItemKindClass", { fg = colors.accent_tertiary })
  set(0, "CmpItemKindModule", { fg = colors.accent_secondary })
  set(0, "CmpItemKindConstant", { fg = colors.fg_secondary })

  -- =========================================================
  -- LAZY
  -- =========================================================
  set(0, "LazyH1", { fg = colors.bg_primary, bg = colors.info, bold = true })
  set(0, "LazyButton", { fg = colors.fg_primary, bg = "NONE" })
  set(0, "LazyButtonActive", { fg = colors.info, bg = colors.bg_tertiary, bold = true })
  set(0, "LazySpecial", { fg = colors.warning })
  set(0, "LazyCommit", { fg = colors.accent_tertiary })
  set(0, "LazyReasonPlugin", { fg = colors.accent_primary })
  set(0, "LazyReasonRuntime", { fg = colors.accent_secondary })

  -- =========================================================
  -- LAZY-GIT
  -- =========================================================
  set(0, "LazyGitFloat", { fg = colors.fg_primary, bg = colors.bg_primary })
  set(0, "LazyGitBorder", { fg = colors.bg_primary, bg = colors.bg_primary })

  -- =========================================================
  -- TROUBLE
  -- =========================================================
  set(0, "TroubleNormal", { fg = colors.fg_primary, bg = colors.bg_primary })
  set(0, "TroubleText", { fg = colors.fg_primary })
  set(0, "TroubleCount", { fg = colors.accent_primary, bold = true })
  set(0, "TroubleCode", { fg = colors.text_faint })

  -- =========================================================
  -- MINI.NVIM
  -- =========================================================
  set(0, "MiniIndentscopeSymbol", { fg = colors.text_faint })
  set(0, "MiniIndentscopeSymbolOff", { fg = colors.text_faint })
  set(0, "MiniCursorWord", { bg = colors.bg_secondary })
  set(0, "MiniCursorWordCurrent", { bg = colors.bg_tertiary })
  set(0, "MiniDiffSignAdd", { fg = colors.hint })
  set(0, "MiniDiffSignChange", { fg = colors.info })
  set(0, "MiniDiffSignDelete", { fg = colors.error })
  set(0, "MiniDiffOverAdd", { fg = colors.hint, bg = colors.bg_primary })
  set(0, "MiniDiffOverChange", { fg = colors.info, bg = colors.bg_primary })
  set(0, "MiniDiffOverDelete", { fg = colors.error, bg = colors.bg_primary })

  -- =========================================================
  -- BLINKS-CMP
  -- =========================================================
  set(0, "BlinkCmpMenu", { fg = colors.fg_primary, bg = colors.bg_secondary })
  set(0, "BlinkCmpDoc", { fg = colors.fg_primary, bg = colors.bg_secondary })

  -- =========================================================
  -- NEO-TREE
  -- =========================================================
  set(0, "NeoTreeNormal", { fg = colors.fg_primary, bg = colors.bg_primary })
  set(0, "NeoTreeNormalNC", { fg = colors.text_muted, bg = colors.bg_primary })
  set(0, "NeoTreeWinSeparator", { fg = colors.bg_secondary })
  set(0, "NeoTreeFloatBorder", { fg = colors.bg_secondary })
  set(0, "NeoTreeTitleBar", { fg = colors.hint })
end

return M
