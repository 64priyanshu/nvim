-- Core files
require("priyanshu.core.options")
require("priyanshu.core.keymaps")
require("priyanshu.core.autocommands")

-- Extras utilitis
require("priyanshu.core.extras.cwd-persistent")
require("priyanshu.core.extras.session")
require("priyanshu.core.extras.view")
require("priyanshu.core.extras.yank-ring")

-- Lazy
require("priyanshu.lazy")

-- LSPs
require("priyanshu.plugins.lsp.diagnostics")
require("priyanshu.plugins.lsp.lspconfig")
