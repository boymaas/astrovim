return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  'marko-cerovac/material.nvim',
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      ignore_lsp = { "lua_ls" },
      detection_methods = { "pattern", "lsp" },
      exclude_dirs = { ".cargo" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },
    },
    config = function(_, opts) require("project_nvim").setup(opts) end,
  },
  { "nvim-telescope/telescope.nvim", opts = function() require("telescope").load_extension "projects" end },
}
