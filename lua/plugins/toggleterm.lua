--- Plugin specification for 'akinsho/toggleterm.nvim'.
--- This configures the ToggleTerm plugin for Neovim, providing terminal integration with custom key mappings and file runners.
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		--- Setup ToggleTerm with custom options.
		require("toggleterm").setup({
			size = 20, -- Default terminal size
			shell = "pwsh.exe", -- Use the default shell
			open_mapping = [[<c-\>]], -- Key mapping to toggle terminal
			hide_numbers = true, -- Hide the number column in toggleterm buffers
			shade_filetypes = {}, -- Filetypes to shade
			shade_terminals = true, -- Enable terminal shading
			shading_factor = 2, -- Degree to darken terminal color
			start_in_insert = true, -- Start terminal in insert mode
			insert_mappings = true, -- Enable open mapping in insert mode
			persist_size = true, -- Persist terminal size
			direction = "horizontal", -- Terminal direction: 'vertical' | 'horizontal' | 'tab' | 'float'
			close_on_exit = true, -- Close terminal window when process exits
		})
	end,
	keys = {
		{
			"<leader>tt",
			--- Toggle the default terminal.
			function()
				require("toggleterm").toggle()
			end,
			desc = "Toggle Terminal",
		},
		{
			"<leader>tf",
			--- Toggle a floating terminal.
			function()
				local count = vim.v.count1
				require("toggleterm").toggle(count, 0, vim.loop.cwd(), "float")
			end,
			desc = "Toggle Float Terminal",
		},
		{
			"<leader>th",
			--- Toggle a horizontal terminal.
			function()
				local count = vim.v.count1
				require("toggleterm").toggle(count, 0, vim.loop.cwd(), "horizontal")
			end,
			desc = "Toggle Horizontal Terminal",
		},
		{
			"<leader>tv",
			--- Toggle a vertical terminal.
			function()
				local count = vim.v.count1
				require("toggleterm").toggle(count, 0, vim.loop.cwd(), "vertical")
			end,
			desc = "Toggle Vertical Terminal",
		},
		{
			"<leader>rf",
			--- Run the current file in a terminal based on its filetype.
			function()
				local filetype = vim.bo.filetype
				local filename = vim.fn.expand("%")
				local cmd = ""

				if filetype == "python" then
					cmd = "python " .. filename
				elseif filetype == "javascript" then
					cmd = "node " .. filename
				elseif filetype == "sh" then
					cmd = "bash " .. filename
				elseif filetype == "java" then
					cmd = "javac " .. filename .. " && java " .. vim.fn.fnamemodify(filename, ":r")
				elseif filetype == "c" then
					cmd = "gcc " .. filename .. " -o out && ./out"
				elseif filetype == "cpp" then
					cmd = "g++ " .. filename .. " -o out && ./out && del ./out.exe"
				end

				if cmd ~= "" then
					require("toggleterm").exec(cmd, 1, 12, "horizontal")
				end
			end,
			desc = "Run File in ToggleTerm",
		},
		{
			"<leader>wpb",
			function()
				local wpilib_root = "C:/Users/Public/wpilib/2025"
				local cmd = "gradlew build -D org.gradle.java.home=" .. wpilib_root .. "/jdk"
				require("toggleterm").exec(cmd, 1, 12, vim.loop.cwd())
			end,
			desc = "Build WPILib project",
		},
		{
			"<leader>wpd",
			function()
				local wpilib_root = "C:/Users/Public/wpilib/2025"
				local cmd = "gradlew deploy -D org.gradle.java.home=" .. wpilib_root .. "/jdk"
				require("toggleterm").exec(cmd, 1, 12, vim.loop.cwd())
			end,
			desc = "Deploy WPILib project",
		},
		{
			"<leader>wps",
			function()
				local wpilib_root = "C:/Users/Public/wpilib/2025"
				local cmd = "gradlew simulateJava -D org.gradle.java.home=" .. wpilib_root .. "/jdk"
				require("toggleterm").exec(cmd, 1, 12, vim.loop.cwd())
			end,
			desc = "Simulate WPILib project",
		},
	},
}
