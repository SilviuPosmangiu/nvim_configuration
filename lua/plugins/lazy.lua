-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	{ "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }},
	{
	    "nvim-tree/nvim-tree.lua",
	    version = "*",
	    lazy = false,
	    requires = {
	      "nvim-tree/nvim-web-devicons",
	    },
	    config = function()
		require("nvim-tree").setup {
		  sort = { sorter = "case_sensitive" },
		  view = {
		    width = 30,
		    adaptive_size = true,
		  },
		  renderer = { group_empty = true },
		  filters = { dotfiles = false },
		}
	      end,
	},
	{'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons'},
	{
	  "rmagatti/auto-session",
	  lazy = false,

	  ---enables autocomplete for opts
	  ---@module "auto-session"
	  ---@type AutoSession.Config
	  opts = {
	    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
	    -- log_level = 'debug',
	  },
	}
  })
