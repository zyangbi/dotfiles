return {
  -- colorscheme
  {
    "Mofiqul/vscode.nvim",
    opts = {
      -- Enable italic comment
      italic_comments = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    enabled = false,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 }, -- relative path
          { "progress" },
          { "searchcount" },
        },
        lualine_x = { "diff" },
        lualine_y = { "diagnostics" },
        lualine_z = {},
      },
      extensions = { "neo-tree", "quickfix", "man", "nvim-dap-ui", "fzf", "fugitive" },
    },
  },

  -- indent line
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = require("mini.indentscope").gen_animation.quadratic({
          easing = "in",
          duration = 50,
          unit = "total",
        }),
      },
    },
  },

  -- terminal
  {
    "NvChad/nvterm",
    keys = {
      -- stylua: ignore
      -- `<Esc><Esc>` enter normal mode, then switch windows
      { "<leader>tt", function() require("nvterm.terminal").toggle("horizontal") end, desc = "toggle term", mode = { "n", "t" } },
    },
    config = function()
      require("nvterm").setup()
    end,
  },

  -- scrollview
  {
    "dstein64/nvim-scrollview",
    event = "BufReadPre",
    opts = {
      excluded_filetypes = { "neo-tree" },
      current_only = true,
      winblend = 0,
    },
  },

  -- outline
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    keys = { { "<leader>co", "<cmd>AerialToggle<cr>", desc = "Aerial Outline" } },
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = { min_width = 40 },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
    },
  },
}
