return {
	{
		"oil.nvim",
		lazy = false,
		after = function()
			require("oil").setup({
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
				lsp_file_methods = {
					enabled = true,
					timeout_ms = 1000,
					autosave_changes = true,
				},
				default_file_explorer = true,
				skip_confirm_for_simple_edits = true,
				delete_to_trash = true,
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
				},
				default_file_explorer = true,
				skip_confirm_for_simple_edits = true,
				promt_save_on_select_new_entry = false,
				cleanup_delay_ms = 2000,
				use_default_keymaps = true,
				watch_for_changes = true,
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
				},
			})

			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
			vim.keymap.set({ "n", "v" }, ".", "<cmd>b#<cr>", { desc = "Go back to last opened buffer" })
		end,
	},
}
