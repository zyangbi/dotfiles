return {
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-dap.nvim" },
		},

		opts = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					color_devicons = false,
					layout_strategy = "flex",
					layout_config = {
						prompt_position = "top",
						anchor = "N",
						height = 0.99,
						width = 0.99,
						horizontal = { preview_width = 0.8 },
					},
					dynamic_preview_title = true,
					path_display = { "tail" },
				},
			})
			telescope.load_extension("dap")
		end,
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		keys = {
			{ "<c-Up>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		opts = {
			ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vim" },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-Up>",
					node_incremental = "<C-Up>",
					scope_incremental = "<nop>",
					node_decremental = "<C-Down>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						-- ["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						-- ["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		},
	},

	-- which-key
	{
		"folke/which-key.nvim",
		opts = function()
			require("which-key").register({
				["<leader>d"] = { name = "+debug", mode = { "n", "v" } },
				["<leader>t"] = { name = "+test" },
			})
		end,
	},

	-- leap
	{
		"ggandor/leap.nvim",
		opts = {
			safe_labels = {},
			labels = {
				"o",
				"e",
				"u",
				"i",
				"d",
				"h",
				"t",
				"n",
				"p",
				"j",
				"k",
				"c",
				"r",
				"m",
				"w",
				"O",
				"E",
				"U",
				"I",
				"D",
				"H",
				"T",
				"N",
				"P",
				"J",
				"K",
				"C",
				"R",
				"M",
				"W",
			},
		},
	},
}
