return {
		"conform.nvim",
		lazy = true,
    after = function()
			conform.setup({
				async = true,
				formatters_by_ft = {
					json = { "oxfmt" },
					json5 = { "oxfmt" },
					lua = { "stylua" },
					md = { "marksman" },
					cs = { lsp_format = "fallback" },
					csproj = { lsp_format = "fallback" },
          nix = { lsp_format = "nixfmt" },
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
}
