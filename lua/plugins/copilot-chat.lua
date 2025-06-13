return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		"github/copilot.vim", -- classic ghost-text & completions
		"nvim-lua/plenary.nvim", -- utility functions
	},
	build = "make tiktoken",
	opts = {
		auto_insert_mode = true, -- immediately prompt
		diff = true, -- show edits as a diff you can apply
		question_header = "  User ",
		answer_header = "  Copilot ",
		window = { width = 0.4 },
	},
	keys = {
		-- open full chat history
		{ "<leader>cco", "<cmd>CopilotChat<cr>", desc = "CopilotChat: Open Chat" },

		-- explain the current visual selection
		{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "CopilotChat: Explain Code" },

		-- review the current visual selection
		{ "<leader>ccr", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "CopilotChat: Review Code" },

		-- refactor the current visual selection
		{ "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", mode = "v", desc = "CopilotChat: Refactor Code" },

		-- automatically fix lint/type errors in selection
		{ "<leader>ccf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "CopilotChat: Fix Code Issues" },

		-- optimize performance or readability
		{ "<leader>cci", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "CopilotChat: Optimize Code" },

		-- generate documentation comments
		{ "<leader>ccd", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "CopilotChat: Generate Docs" },

		-- generate unit tests for the selection
		{ "<leader>cct", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "CopilotChat: Generate Tests" },
	},
}
