syn match qfFileName       /^[^|]*/  nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft  /|/       contained nextgroup=qfLineNr
syn match qfLineNr         /[^|]*/   contained contains=qfError,qfWarning,qfNote,qfInfo nextgroup=qfSeparatorRight
syn match qfError          /error/   contained
syn match qfWarning        /warning/ contained
syn match qfInfo           /info/    contained
syn match qfNote           /note/    contained
syn match qfSeparatorRight /|/       contained

" Link new syntax highlight groups
hi  def link qfFileName       Directory
hi  def link qfSeparatorLeft  Delimiter
hi  def link qfLineNr         LineNr
hi  def link qfSeparatorRight Delimiter
hi! def link qfError          DiagnosticError
hi! def link qfWarning        DiagnosticWarn
hi! def link qfInfo           DiagnosticInfo
hi! def link qfNote           DiagnosticHint
