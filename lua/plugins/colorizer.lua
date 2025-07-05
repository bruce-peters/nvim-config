return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = { -- set to setup table
		user_default_options = {
			names = false, -- disable names
			mode = "background", -- set mode to background
			tailwind = true, -- enable tailwind support
			css = true, -- enable CSS support
		},
	},
}
