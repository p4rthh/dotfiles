-- ==========================================================================
-- 1. BOOTSTRAP LAZY.NVIM (The Plugin Manager)
--    This code automatically downloads the plugin manager if you don't have it.
-- ==========================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================================================
-- 2. BASIC SETTINGS (Making it behave nicely)
-- ==========================================================================
vim.g.mapleader = " "          -- Sets the "Leader" key to Space (crucial for shortcuts)
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers (great for jumping lines)
vim.opt.mouse = "a"            -- Enable mouse support (clicking works!)
vim.opt.clipboard = "unnamedplus" -- Copy/Paste shares with Windows Clipboard
vim.opt.termguicolors = true   -- Enable 24-bit RGB colors (makes themes look correct)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- ==========================================================================
-- 3. PLUGINS (The "Cool" Stuff)
-- ==========================================================================
require("lazy").setup({
  -- FORMATTING: Conform.nvim
  -- FEATURE: Auto-formats code (Prettier, etc.) when you save.
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        -- Define which formatters to use for which languages
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" }, -- (Optional) You can install stylua for Lua formatting
        },
        -- Enable "Format on Save"
        format_on_save = {
          lsp_fallback = true,    -- Use LSP formatting if prettier isn't available
          async = false,          -- block until formatting is done
          timeout_ms = 1000,      -- give it 1 second max
        },
      })
    end,
  },

  -- THEME: Catppuccin/Mocha
  -- FEATURE: Just a color scheme setup
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false, -- Enable this if you want your OS background
        integrations = {
          neo_tree = true,
          telescope = true,
          bufferline = true,
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- STATUS BAR: Lualine
  -- FEATURE: Replaces the boring bottom bar with a colorful, icon-rich status line.
  -- It shows your git branch, file type, and current mode.
  -- STATUS BAR: Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "catppuccin" } })
    end,
  },

  -- FILE EXPLORER: Neo-tree
  -- FEATURE: A visual file tree on the left side (like VS Code).
  -- USAGE: Press 'Space' then 'e' to toggle it.
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle File Explorer" },
    },
  },

  -- FUZZY FINDER: Telescope
  -- FEATURE: The "Google Search" of your code. Find files instantly without browsing folders.
  -- USAGE: 
  --   Space + f + f : Find File
  --   Space + f + g : Find Text (Grep) inside files
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
    },
  },

  -- SYNTAX HIGHLIGHTING: Treesitter
  -- FEATURE: Makes code colorful and easier to read by understanding the language grammar.
  -- It's much smarter than standard regex highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- CHEATSHEET: Which-Key
  -- FEATURE: If you press "Space" and wait, a menu pops up showing you all available commands.
  -- You never have to memorize shortcuts again.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  }
})
