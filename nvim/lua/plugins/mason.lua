return {
  -- cmdline tools and lsp servers
  -- https://github.com/williamboman/mason.nvim/tree/main/lua/mason-registry
  -- https://github.com/williamboman/mason.nvim/blob/main/lua/mason-core/package/init.lua#L39-L47
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- C++
        "clangd",
        "cpptools",
        "clang-format",
        "cpplint",
        -- Go
        "gopls",
        "goimports",
        "golangci-lint",
        "golangci-lint-langserver", -- Wraps golangci-lint as a language server
        "delve",
        -- Lua
        "lua-language-server",
        "stylua",
        "selene",
        -- Shell
        "bash-language-server",
        "shfmt",
        "shellcheck", -- bashls integrated
        -- JavaScript
        "prettierd",
      },
    },
  },

  -- formatters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- lua
          nls.builtins.formatting.stylua,
          -- nls.builtins.diagnostics.selene.with({
          --   condition = function(utils)
          --     return utils.root_has_file({ "selene.toml" })
          --   end,
          -- }),
          -- shell
          nls.builtins.formatting.shfmt,
          -- golang
          nls.builtins.formatting.goimports,
          -- cpp
          -- nls.builtins.formatting.clang_format,
          -- typescript/javascript
          nls.builtins.formatting.prettierd,
        },
      }
    end,
  },
}
