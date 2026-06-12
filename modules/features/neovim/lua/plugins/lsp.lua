return {
	{
		"todo-comments.nvim",
		after = function()
			require("todo-comments").setup()
		end,
	},
	{
		"vimtex",
		lazy = false,
		after = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"lazydev.nvim",
		ft = "lua",
		after = function()
			require("lazydev").setup({
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			})
		end,
	},
	{
		"nvim-autopairs",
		event = "InsertEnter",
		after = function()
			require("nvim-autopairs").setup({})
		end,
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
		cmd = "IncRename",
		after = function()
			require("inc_rename").setup({})
		end,
	},
	{
		"nvim-lspconfig",
		lazy = false,
		after = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities({
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			})

			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git" },
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			local hostname = vim.fn.hostname()
			local user = vim.env.USER

			vim.lsp.config("nixd", {
				cmd = { "nixd" },
				filetypes = { "nix" },
				root_markers = { "flake.nix" },
				settings = {
					nixd = {
						nixpkgs = {
							expr = "import <nixpkgs> { }",
						},
						options = {
							nixos = {
								expr = "(builtins.getFlake (toString ./.)).nixosConfigurations."
									.. hostname
									.. ".options",
							},
							home_manager = {
								expr = "(builtins.getFlake (toString ./.)).homeConfigurations."
									.. user
									.. "@"
									.. hostname
									.. ".options",
							},
						},
					},
				},
			})

			vim.lsp.enable({ "lua_ls", "nixd" })

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
					yaml = { "yamlfmt" },
					javascript = { "oxfmt" },
					lua = { "stylua" },
					cs = { lsp_format = "fallback" },
					csproj = { lsp_format = "fallback" },
					nix = { "nixfmt" },
					tex = { "tex-fmt" },
					plaintex = { "tex-fmt" },
					bib = { "bibtex-tidy" },

					["*"] = { "codespell" },
					["_"] = { "trim_whitespace" },
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
