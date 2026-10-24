-- TODO ----------
-- set up debugger dap
-- set up git
-- set up codeactions
-- set up treesitter
-- set lualine square

-- CONFIGS ----------
vim.cmd.colorscheme('retrobox') -- colorscheme global

-- PLUGINS ----------
vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' }, -- automatically finding default  lsp configs
  { src = 'https://github.com/mason-org/mason.nvim' }, -- managing lsps and stuff
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' }, -- autoenables lsps when downloaded
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' }, -- autosintalls mason tools' stuff
  { src = 'https://github.com/nvim-telescope/telescope.nvim.git' }, -- searching, finding, filtering etc
  { src = 'https://github.com/nvim-lualine/lualine.nvim' }, -- status line
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  }, -- file browser
  {
	src = "https://github.com/saghen/blink.cmp",
	version = vim.version.range("^1"),
  }, -- autocompletion
  {src = "https://github.com/nvim-treesitter/nvim-treesitter.git"}, -- plugin for tree sitter parsing

  -- dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    -- optional, but recommended
    "https://github.com/nvim-tree/nvim-web-devicons",

}

require('nvim-treesitter').setup({})
require('neo-tree').setup({})
require('lualine').setup{ options = {theme = 'auto'}}
require('telescope').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
  -- these will be autoinstalled and autoconfigured  if not done already 
  ensure_installed = {
    "lua_ls",
    "stylua",
    "pyright",
    "pylsp"
  }
})

-- KEYMAPS ----------
vim.g.mapleader = " "
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }) 
vim.keymap.set('n', '<C-n>', '<Cmd>Neotree toggle<CR>')

-- PLUGIN CONFIGS----------
-- blink.cpm ----------
  -- Lazy load on first insert mode entry (may not necessary)
  local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

  vim.api.nvim_create_autocmd("InsertEnter", {
      pattern = "*",
      group = group,
      once = true,
      callback = function()
          require("blink.cmp").setup({
              keymap = { preset = "super-tab" },
              appearance = {
                  nerd_font_variant = "mono",
                  use_nvim_cmp_as_default = true,
              },
              completion = {
                  documentation = { auto_show = false },
              },
              sources = {
                  default = { "lsp", "path", "snippets", "buffer" },
              },
              fuzzy = { implementation = "prefer_rust_with_warning" },
          })
      end,
  })
