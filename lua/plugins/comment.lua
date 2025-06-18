return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		comment.setup({
			-- for commenting tsx, jsx, svelte, html files
			pre_hook = ts_context_commentstring.create_pre_hook(),
			mappings = {
				basic = true, -- includes default mappings for normal mode
				extra = true, -- disables extra mappings like `gcc` for toggling comments
			},
		})
		-- set up keymaps for commenting
		vim.keymap.set("n", "<C-_>", ":normal gcc<CR><DOWN>", { desc = "[/] Toggle comment line" })
		vim.keymap.set("v", "<C-_>", "<Esc>:normal gvgc<CR>", { desc = "[/] Toggle comment block" })
	end,
}
