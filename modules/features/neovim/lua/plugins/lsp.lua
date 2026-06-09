return {
	{
		"lazydev.nvim",
		ft = "lua",
		after = function() end,
	},
	{
		"nvim-autopairs",
		lazy = false,
		event = "InsertEnter",
		after = function() end,
	},
	{
		"trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
		after = function()
			require("trouble").setup({})
		end,
	},
	{
		"inc-rename.nvim",
		after = function()
			require("inc_rename").setup()
		end,
	},
	{
		"nvim-lspconfig",
		event = "BufReadPre",
		after = function()
			local capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			}

			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git" },
			})

			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = false,
				severity_sort = true,
				update_in_insert = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
			})
		end,
	},
	{
		"conform.nvim",
		event = "BufWritePre",
		after = function()
			require("conform").setup({
				async = true,
				formatters_by_ft = {
					json = { "oxfmt" },
					json5 = { "oxfmt" },
					lua = { "stylua" },
					md = { "marksman" },
					cs = { lsp_format = "fallback" },
					csproj = { lsp_format = "fallback" },
					nix = { "nixfmt" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},

				format_after_save = {
					lsp_format = "fallback",
				},
			})

			vim.keymap.set("n", "<leader>F", function()
				require("conform").format({ async = true })
			end, { desc = "Format current buffer" })
		end,
	},
	{
		"gitsigns.nvim",
		event = "BufReadPre",
		after = function()
			require("gitsigns").setup({})
		end,
	},
}
