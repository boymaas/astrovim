-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    -- faster page-up and down
    ["<C-j>"] = { "<C-f>" },
    ["<C-k>"] = { "<C-b>" },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    [";f"] = { function() require('telescope.builtin').find_files() end },
    [";F"] = { function() require('telescope.builtin').git_files() end },
    [";p"] = { ":Telescope projects<CR>" },
    [";b"] = { function() require('telescope.builtin').buffers() end },
    [";;"] = { ":b#<cr>" },
    -- Testing
    [";t"] = { ":TestLast<CR>" },
    [";T"] = { ":TestNearest<CR>" },
    -- LSP
    ["<Leader>a"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Code action" },
    ["<leader>d"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
    ["L"] = { "gl" },
    -- Window movement
    ["<S-Left>"] = { "<C-w>h" },
    ["<S-Down>"] = { "<C-w>j" },
    ["<S-Up>"] = { "<C-w>k" },
    ["<S-Right>"] = { "<C-w>l" },
  },
  v = {
    -- LSP
    ["<Leader>a"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Code action" }
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
