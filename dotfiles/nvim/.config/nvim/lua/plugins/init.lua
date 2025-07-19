require("lazy").setup({
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki-hugo/content",
          syntax = "markdown",
          ext = ".md",
          auto_export = 0,
          links_space_char = "_",
          template_path = "~/vimwiki-hugo/templates",
          template_default = "default",
          template_ext = ".md",
          index = "_index",
        },
      }
      vim.g.vimwiki_diary_rel_path = "posts"
      vim.g.vimwiki_diary_index = "_index"
      vim.g.vimwiki_markdown_link_ext = 1
      -- REMOVE: Lua-side templates, now handled from disk files per Vimwiki templates
    end,
  },

  -- 🔧 Core dependencies
  { "nvim-lua/plenary.nvim" },

  -- LSP support
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
  'plasticboy/vim-markdown',
  branch = 'master',
  require = {'godlygeek/tabular'},
},

  -- Formatters and linters
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.codespell,
        },
      })
    end,
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
}, {
  rocks = {
    enabled = false,
  },
})