vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("blink.cmp").setup({
	-- Keymap: https://cmp.saghen.dev/configuration/keymap#default
	keymap = { preset = "default" },

	-- Appearance
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
		kind_icons = { -- Custom kind_icons
			Text = "",
			Method = "",
			Function = "󰊕",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	},

	-- Cmdline
	cmdline = { enabled = false },

	-- Sources
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			snippets = {
				opts = {
					friendly_snippets = true, -- default
					extended_filetypes = {
						-- text = { "html" },
					},
				},
			},
		},
	},

	-- Signature Help
	signature = {
		enabled = true,
		trigger = { enabled = false },
		window = {
			treesitter_highlighting = true,
			show_documentation = false,
		},
	},

	-- Completion
	completion = {
		keyword = { range = "prefix" },
		list = { selection = { preselect = true, auto_insert = false } },
		documentation = { auto_show = true, auto_show_delay_ms = 100 },
		accept = { auto_brackets = { enabled = true } },
		menu = {
			auto_show = true,
			draw = {
				-- treesitter = { "lsp" },
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
				components = {
					kind = {
						text = function(ctx)
							return ctx.kind:lower()
						end,
					},
				},
			},
		},
	},
})
