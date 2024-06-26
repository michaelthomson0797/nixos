local api = vim.api
local g = vim.g
local opt = vim.opt

-- Load Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "


-- Load plugins
require('lazy').setup('plugins')

vim.cmd 'colorscheme catppuccin-frappe'

-- Load core settings
opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = false -- turn off highlight on search
opt.incsearch = true -- Keep incremental highlighting on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 50 --Decrease update time
opt.signcolumn = 'yes' -- Always show sign column
opt.clipboard = 'unnamedplus' -- Access system clipboard
opt.laststatus = 3 -- Global status line
opt.swapfile = false
opt.wrap = false
vim.opt_local.conceallevel = 2
vim.opt.inccommand = 'split'

-- Time in milliseconds to wait for a mapped sequence to complete.
opt.timeoutlen = 300

opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 10 -- Lines of context
opt.smartindent = true --Smart indent
opt.expandtab = true
opt.smarttab = true
opt.textwidth = 0
opt.autoindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.cursorline = true
opt.guifont = "PragmataPro Mono Liga"

-- Remappings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<c-f>", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>fe", "<cmd>Oil<CR>")

vim.keymap.set("i", "jk", "<Esc>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
