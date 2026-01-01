local H = {}

function H.apply()
  local function set(group_id, group_name, opts)
    vim.api.nvim_set_hl(group_id, group_name, opts)
  end

  -- =========================================================
  -- COLORS DEFINITION
  -- =========================================================
  local c = require("config.colors")

  -- =========================================================
  -- CORE EDITOR
  -- =========================================================
  set(0, "Normal", { fg = c.fg_primary, bg = "NONE" })
  set(0, "NormalNC", { fg = c.text_muted, bg = "NONE" })
  set(0, "EndOfBuffer", { fg = c.text_faint, bg = "NONE" })
  set(0, "LineNr", { fg = c.text_faint, bg = "NONE" })
  set(0, "CursorLineNr", { fg = c.fg_secondary, bold = true })
  set(0, "CursorLine", { bg = "NONE" })
  set(0, "CursorColumn", { bg = "NONE" })
  set(0, "ColorColumn", { bg = "NONE" })
  set(0, "SignColumn", { bg = "NONE" })
  set(0, "Whitespace", { fg = c.bg_tertiary })
  set(0, "NonText", { fg = c.text_faint })
  set(0, "SpecialKey", { fg = c.text_faint })
  set(0, "Conceal", { fg = c.info })
  set(0, "Directory", { fg = c.info, bold = true })
  set(0, "Title", { fg = c.accent_tertiary, bold = true })
  set(0, "YankedText", { fg = c.bg_primary, bg = c.hint })

  -- =========================================================
  -- CURSOR
  -- =========================================================
  set(0, "Cursor", { fg = c.bg_primary, bg = c.fg_primary })
  set(0, "lCursor", { fg = c.bg_primary, bg = c.fg_primary })
  set(0, "CursorIM", { fg = c.bg_primary, bg = c.fg_primary })
  set(0, "TermCursor", { fg = c.bg_primary, bg = c.fg_primary })
  set(0, "TermCursorNC", { fg = c.bg_primary, bg = c.text_faint })

  -- =========================================================
  -- VISUAL / SEARCH / MATCH
  -- =========================================================
  set(0, "Visual", { bg = c.bg_tertiary })
  set(0, "VisualNOS", { bg = c.bg_tertiary })
  set(0, "Search", { fg = c.bg_primary, bg = c.accent_tertiary })
  set(0, "IncSearch", { fg = c.bg_primary, bg = c.warning, bold = true })
  set(0, "CurSearch", { fg = c.bg_primary, bg = c.error, bold = true })
  set(0, "Substitute", { fg = c.bg_primary, bg = c.warning })
  set(0, "MatchParen", { fg = c.warning, bold = true })

  -- =========================================================
  -- FLOATING WINDOWS / PMENU
  -- =========================================================
  set(0, "NormalFloat", { fg = c.fg_primary, bg = c.bg_secondary })
  set(0, "FloatBorder", { fg = c.text_faint, bg = "NONE" })
  set(0, "FloatTitle", { fg = c.accent_tertiary, bg = "NONE", bold = true })
  set(0, "FloatFooter", { fg = c.text_faint, bg = "NONE" })
  set(0, "Pmenu", { fg = c.fg_primary, bg = "NONE" })
  set(0, "PmenuSel", { fg = c.bg_primary, bg = c.hint, bold = true })
  set(0, "PmenuBorder", { fg = c.text_faint, bg = "NONE" })
  set(0, "PmenuSbar", { bg = c.bg_secondary })
  set(0, "PmenuThumb", { bg = c.text_faint })
  set(0, "PmenuKind", { fg = c.accent_primary, bg = c.bg_secondary })
  set(0, "PmenuKindSel", { fg = c.bg_primary, bg = c.hint, bold = true })
  set(0, "PmenuExtra", { fg = c.text_muted, bg = c.bg_secondary })
  set(0, "PmenuExtraSel", { fg = c.bg_primary, bg = c.hint })

  -- =========================================================
  -- MESSAGES / COMMAND LINE
  -- =========================================================
  set(0, "MsgArea", { fg = c.fg_primary })
  set(0, "MsgSeparator", { fg = c.text_faint, bg = c.bg_secondary })
  set(0, "MoreMsg", { fg = c.hint, bold = true })
  set(0, "Question", { fg = c.accent_tertiary, bold = true })
  set(0, "WarningMsg", { fg = c.warning, bold = true })
  set(0, "ErrorMsg", { fg = c.error, bold = true })
  set(0, "ModeMsg", { fg = c.fg_secondary, bold = true })

  -- =========================================================
  -- DIAGNOSTICS
  -- =========================================================
  set(0, "DiagnosticError", { fg = c.error })
  set(0, "DiagnosticWarn", { fg = c.warning })
  set(0, "DiagnosticInfo", { fg = c.info })
  set(0, "DiagnosticHint", { fg = c.hint })
  set(0, "DiagnosticOk", { fg = c.accent_secondary })
  set(0, "DiagnosticUnderlineError", { sp = c.error, undercurl = true })
  set(0, "DiagnosticUnderlineWarn", { sp = c.warning, undercurl = true })
  set(0, "DiagnosticUnderlineInfo", { sp = c.info, undercurl = true })
  set(0, "DiagnosticUnderlineHint", { sp = c.hint, undercurl = true })
  set(0, "DiagnosticUnderlineOk", { sp = c.accent_secondary, undercurl = true })
  set(0, "DiagnosticVirtualTextError", { fg = c.error, bg = c.bg_primary })
  set(0, "DiagnosticVirtualTextWarn", { fg = c.warning, bg = c.bg_primary })
  set(0, "DiagnosticVirtualTextInfo", { fg = c.info, bg = c.bg_primary })
  set(0, "DiagnosticVirtualTextHint", { fg = c.hint, bg = c.bg_primary })
  set(0, "DiagnosticSignError", { fg = c.error })
  set(0, "DiagnosticSignWarn", { fg = c.warning })
  set(0, "DiagnosticSignInfo", { fg = c.info })
  set(0, "DiagnosticSignHint", { fg = c.hint })

  -- =========================================================
  -- SPLITS / BORDERS
  -- =========================================================
  set(0, "WinSeparator", { fg = c.bg_tertiary })
  set(0, "VertSplit", { fg = c.bg_tertiary })

  -- =========================================================
  -- STATUS LINE
  -- =========================================================
  set(0, "StatusLine", { fg = c.text_muted, bg = "NONE" })
  set(0, "StatusLineNC", { fg = c.text_faint, bg = c.bg_primary })

  -- =========================================================
  -- TABLINE
  -- =========================================================
  set(0, "TabLine", { fg = c.text_faint, bg = c.bg_primary })
  set(0, "TabLineFill", { bg = c.bg_primary })
  set(0, "TabLineSel", { fg = c.accent_primary, bg = c.bg_secondary, bold = true })

  -- =========================================================
  -- SPELL CHECKING
  -- =========================================================
  set(0, "SpellBad", { sp = c.error, undercurl = true })
  set(0, "SpellCap", { sp = c.info, undercurl = true })
  set(0, "SpellLocal", { sp = c.accent_secondary, undercurl = true })
  set(0, "SpellRare", { sp = c.accent_primary, undercurl = true })

  -- =========================================================
  -- DIFF
  -- =========================================================
  set(0, "DiffAdd", { fg = c.hint, bg = c.bg_primary })
  set(0, "DiffChange", { fg = c.info, bg = c.bg_primary })
  set(0, "DiffDelete", { fg = c.error, bg = c.bg_primary })
  set(0, "DiffText", { fg = c.accent_tertiary, bg = c.bg_primary, bold = true })
  set(0, "diffAdded", { fg = c.hint })
  set(0, "diffRemoved", { fg = c.error })
  set(0, "diffChanged", { fg = c.info })
  set(0, "diffFile", { fg = c.warning })
  set(0, "diffNewFile", { fg = c.accent_tertiary })
  set(0, "diffLine", { fg = c.accent_secondary })

  -- =========================================================
  -- FOLDING
  -- =========================================================
  set(0, "Folded", { fg = c.text_faint, bg = c.bg_primary, italic = true })
  set(0, "FoldColumn", { fg = c.text_faint, bg = "NONE" })

  -- =========================================================
  -- QUICKFIX / LOCATION LIST
  -- =========================================================
  set(0, "QuickFixLine", { bg = c.bg_tertiary, bold = true })
  set(0, "qfLineNr", { fg = c.accent_tertiary })
  set(0, "qfFileName", { fg = c.info })

  -- =========================================================
  -- WILDMENU
  -- =========================================================
  set(0, "WildMenu", { fg = c.bg_primary, bg = c.info, bold = true })

  -- =========================================================
  -- SYNTAX - BASE GROUPS
  -- =========================================================
  -- Keywords and control flow
  set(0, "Keyword", { fg = c.info, italic = true })
  set(0, "Statement", { fg = c.info, italic = true })
  set(0, "Conditional", { fg = c.info, italic = true })
  set(0, "Repeat", { fg = c.info, italic = true })
  set(0, "Label", { fg = c.info, italic = true })
  set(0, "Exception", { fg = c.info, italic = true })
  set(0, "Include", { fg = c.info, italic = true })
  set(0, "Define", { fg = c.info, italic = true })
  set(0, "Macro", { fg = c.accent_secondary })
  set(0, "PreProc", { fg = c.accent_secondary })
  set(0, "PreCondit", { fg = c.accent_secondary })

  -- Types and structures
  set(0, "Type", { fg = c.accent_tertiary })
  set(0, "StorageClass", { fg = c.warning })
  set(0, "Structure", { fg = c.accent_secondary })
  set(0, "Typedef", { fg = c.accent_tertiary })

  -- Functions and methods
  set(0, "Function", { fg = c.accent_primary })

  -- Variables and identifiers
  set(0, "Identifier", { fg = c.fg_primary })

  -- Constants and literals
  set(0, "Constant", { fg = c.fg_secondary })
  set(0, "Boolean", { fg = c.accent_primary })
  set(0, "Number", { fg = c.warning })
  set(0, "Float", { fg = c.warning })
  set(0, "String", { fg = c.hint })
  set(0, "Character", { fg = c.hint })

  -- Operators and delimiters
  set(0, "Operator", { fg = c.text_muted })
  set(0, "Delimiter", { fg = c.text_muted })

  -- Special elements
  set(0, "Special", { fg = c.warning })
  set(0, "SpecialChar", { fg = c.text_muted })
  set(0, "SpecialComment", { fg = c.text_faint, italic = true })
  set(0, "Tag", { fg = c.accent_secondary })
  set(0, "Debug", { fg = c.error })

  -- Comments and annotations
  set(0, "Comment", { fg = c.text_faint, italic = true })
  set(0, "Todo", { fg = c.accent_tertiary, bold = true })
  set(0, "Note", { fg = c.info, bold = true })
  set(0, "Error", { fg = c.error, bold = true })
  set(0, "Warning", { fg = c.warning, bold = true })

  -- Underlined and markup
  set(0, "Underlined", { fg = c.info, underline = true })
  set(0, "Ignore", { fg = c.text_faint })

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
  set(0, "@constructor", { fg = c.accent_tertiary })

  -- Variables
  set(0, "@variable", { link = "Identifier" })
  set(0, "@variable.builtin", { fg = c.warning })
  set(0, "@variable.parameter", { fg = c.fg_secondary })
  set(0, "@variable.member", { fg = c.fg_secondary })
  set(0, "@property", { fg = c.fg_secondary })
  set(0, "@field", { fg = c.fg_secondary })

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
  set(0, "@namespace", { fg = c.accent_secondary })
  set(0, "@module", { fg = c.accent_secondary })

  -- Literals
  set(0, "@string", { link = "String" })
  set(0, "@string.regex", { fg = c.warning })
  set(0, "@string.escape", { fg = c.error })
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
  set(0, "@punctuation.special", { fg = c.warning })

  -- Comments
  set(0, "@comment", { link = "Comment" })
  set(0, "@comment.documentation", { fg = c.text_muted, italic = true })
  set(0, "@comment.error", { fg = c.error, bold = true })
  set(0, "@comment.warning", { fg = c.warning, bold = true })
  set(0, "@comment.note", { fg = c.info, bold = true })
  set(0, "@comment.todo", { link = "Todo" })

  -- Labels and tags
  set(0, "@label", { link = "Label" })
  set(0, "@tag", { link = "Tag" })
  set(0, "@tag.attribute", { fg = c.accent_secondary })
  set(0, "@tag.delimiter", { link = "Delimiter" })

  -- Markup (Markdown, etc)
  set(0, "@markup.strong", { bold = true })
  set(0, "@markup.italic", { italic = true })
  set(0, "@markup.underline", { underline = true })
  set(0, "@markup.strikethrough", { strikethrough = true })
  set(0, "@markup.heading", { fg = c.accent_tertiary, bold = true })
  set(0, "@markup.heading.1", { fg = c.error, bold = true })
  set(0, "@markup.heading.2", { fg = c.warning, bold = true })
  set(0, "@markup.heading.3", { fg = c.accent_tertiary, bold = true })
  set(0, "@markup.heading.4", { fg = c.hint, bold = true })
  set(0, "@markup.heading.5", { fg = c.info, bold = true })
  set(0, "@markup.heading.6", { fg = c.accent_primary, bold = true })
  set(0, "@markup.quote", { fg = c.text_muted, italic = true })
  set(0, "@markup.math", { fg = c.info })
  set(0, "@markup.link", { fg = c.info, underline = true })
  set(0, "@markup.link.label", { fg = c.accent_secondary })
  set(0, "@markup.link.url", { fg = c.info, underline = true })
  set(0, "@markup.raw", { fg = c.hint })
  set(0, "@markup.raw.block", { fg = c.hint })
  set(0, "@markup.list", { fg = c.warning })
  set(0, "@markup.list.checked", { fg = c.hint })
  set(0, "@markup.list.unchecked", { fg = c.text_faint })

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
  set(0, "@text.literal", { fg = c.hint })
  set(0, "@text.uri", { fg = c.info, underline = true })
  set(0, "@text.reference", { fg = c.accent_secondary })

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
  set(0, "GitSignsAdd", { fg = c.hint })
  set(0, "GitSignsChange", { fg = c.info })
  set(0, "GitSignsDelete", { fg = c.error })
  set(0, "GitSignsAddLn", { fg = c.hint, bg = c.bg_primary })
  set(0, "GitSignsChangeLn", { fg = c.info, bg = c.bg_primary })
  set(0, "GitSignsDeleteLn", { fg = c.error, bg = c.bg_primary })

  -- =========================================================
  -- TELESCOPE
  -- =========================================================
  set(0, "TelescopeBorder", { fg = c.text_faint, bg = c.bg_primary })
  set(0, "TelescopePromptBorder", { fg = c.text_faint, bg = c.bg_primary })
  set(0, "TelescopeResultsBorder", { fg = c.text_faint, bg = c.bg_primary })
  set(0, "TelescopePreviewBorder", { fg = c.text_faint, bg = c.bg_primary })
  set(0, "TelescopeSelection", { fg = c.fg_secondary, bg = c.bg_tertiary, bold = true })
  set(0, "TelescopeSelectionCaret", { fg = c.warning, bg = c.bg_tertiary })
  set(0, "TelescopeMultiSelection", { fg = c.accent_primary, bg = c.bg_tertiary })
  set(0, "TelescopeNormal", { fg = c.fg_primary, bg = c.bg_primary })
  set(0, "TelescopeMatching", { fg = c.accent_tertiary, bold = true })
  set(0, "TelescopePromptPrefix", { fg = c.info, bold = true })
  set(0, "TelescopeTitle", { fg = c.accent_tertiary, bold = true })

  -- =========================================================
  -- INDENT BLANKLINE
  -- =========================================================
  set(0, "IndentBlanklineChar", { fg = c.bg_tertiary })
  set(0, "IndentBlanklineContextChar", { fg = c.text_faint })
  set(0, "IndentBlanklineContextStart", { sp = c.text_faint, underline = true })

  -- =========================================================
  -- NOTIFY
  -- =========================================================
  set(0, "NotifyERRORTitle", { fg = c.error, bold = true })
  set(0, "NotifyERRORIcon", { fg = c.error })
  set(0, "NotifyERRORBody", { fg = c.fg_primary, bg = "NONE" })
  set(0, "NotifyERRORBorder", { fg = c.error, bg = c.bg_primary })

  set(0, "NotifyWARNTitle", { fg = c.warning, bold = true })
  set(0, "NotifyWARNIcon", { fg = c.warning })
  set(0, "NotifyWARNBody", { fg = c.fg_primary, bg = "NONE" })
  set(0, "NotifyWARNBorder", { fg = c.warning, bg = c.bg_primary })

  set(0, "NotifyINFOTitle", { fg = c.info, bold = true })
  set(0, "NotifyINFOIcon", { fg = c.info })
  set(0, "NotifyINFOBody", { fg = c.fg_primary, bg = "NONE" })
  set(0, "NotifyINFOBorder", { fg = c.info, bg = c.bg_primary })

  set(0, "NotifyDEBUGTitle", { fg = c.text_faint, bold = true })
  set(0, "NotifyDEBUGIcon", { fg = c.text_faint })
  set(0, "NotifyDEBUGBody", { fg = c.fg_primary, bg = "NONE" })
  set(0, "NotifyDEBUGBorder", { fg = c.text_faint, bg = c.bg_primary })

  set(0, "NotifyTRACETitle", { fg = c.accent_primary, bold = true })
  set(0, "NotifyTRACEIcon", { fg = c.accent_primary })
  set(0, "NotifyTRACEBody", { fg = c.fg_primary, bg = "NONE" })
  set(0, "NotifyTRACEBorder", { fg = c.accent_primary, bg = c.bg_primary })

  set(0, "NotifyBackground", { bg = "NONE" })

  -- =========================================================
  -- CMP
  -- =========================================================
  set(0, "CmpItemAbbrMatch", { fg = c.accent_tertiary, bold = true })
  set(0, "CmpItemAbbrMatchFuzzy", { fg = c.accent_tertiary })
  set(0, "CmpItemKindVariable", { fg = c.fg_primary })
  set(0, "CmpItemKindInterface", { fg = c.accent_tertiary })
  set(0, "CmpItemKindText", { fg = c.fg_primary })
  set(0, "CmpItemKindFunction", { fg = c.accent_primary })
  set(0, "CmpItemKindMethod", { fg = c.accent_primary })
  set(0, "CmpItemKindKeyword", { fg = c.info })
  set(0, "CmpItemKindProperty", { fg = c.fg_secondary })
  set(0, "CmpItemKindUnit", { fg = c.warning })
  set(0, "CmpItemKindClass", { fg = c.accent_tertiary })
  set(0, "CmpItemKindModule", { fg = c.accent_secondary })
  set(0, "CmpItemKindConstant", { fg = c.fg_secondary })

  -- =========================================================
  -- LAZY
  -- =========================================================
  set(0, "LazyH1", { fg = c.bg_primary, bg = c.info, bold = true })
  set(0, "LazyButton", { fg = c.fg_primary, bg = "NONE" })
  set(0, "LazyButtonActive", { fg = c.info, bg = c.bg_tertiary, bold = true })
  set(0, "LazySpecial", { fg = c.warning })
  set(0, "LazyCommit", { fg = c.accent_tertiary })
  set(0, "LazyReasonPlugin", { fg = c.accent_primary })
  set(0, "LazyReasonRuntime", { fg = c.accent_secondary })

  -- =========================================================
  -- LAZY-GIT
  -- =========================================================
  set(0, "LazyGitFloat", { fg = c.fg_primary, bg = c.bg_primary })
  set(0, "LazyGitBorder", { fg = c.bg_primary, bg = c.bg_primary })

  -- =========================================================
  -- TROUBLE
  -- =========================================================
  set(0, "TroubleNormal", { fg = c.fg_primary, bg = c.bg_primary })
  set(0, "TroubleText", { fg = c.fg_primary })
  set(0, "TroubleCount", { fg = c.accent_primary, bold = true })
  set(0, "TroubleCode", { fg = c.text_faint })

  -- =========================================================
  -- MINI.NVIM
  -- =========================================================
  set(0, "MiniIndentscopeSymbol", { fg = c.text_faint })
  set(0, "MiniIndentscopeSymbolOff", { fg = c.text_faint })
  set(0, "MiniCursorWord", { bg = c.bg_secondary })
  set(0, "MiniCursorWordCurrent", { bg = c.bg_tertiary })
  set(0, "MiniDiffSignAdd", { fg = c.hint })
  set(0, "MiniDiffSignChange", { fg = c.info })
  set(0, "MiniDiffSignDelete", { fg = c.error })
  set(0, "MiniDiffOverAdd", { fg = c.hint, bg = c.bg_primary })
  set(0, "MiniDiffOverChange", { fg = c.info, bg = c.bg_primary })
  set(0, "MiniDiffOverDelete", { fg = c.error, bg = c.bg_primary })

  -- =========================================================
  -- BLINKS-CMP
  -- =========================================================
  set(0, "BlinkCmpMenu", { fg = c.fg_primary, bg = c.bg_secondary })
  set(0, "BlinkCmpDoc", { fg = c.fg_primary, bg = c.bg_secondary })

  -- =========================================================
  -- NEO-TREE
  -- =========================================================
  set(0, "NeoTreeNormal", { fg = c.fg_primary, bg = c.bg_primary })
  set(0, "NeoTreeNormalNC", { fg = c.text_muted, bg = "NONE" })
  set(0, "NeoTreeWinSeparator", { fg = c.bg_secondary })
  set(0, "NeoTreeFloatBorder", { fg = c.bg_secondary, bg = "NONE" })
  set(0, "NeoTreeTitleBar", { fg = c.hint, bg = "NONE" })
end

return H
