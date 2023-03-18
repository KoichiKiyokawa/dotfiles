-------------------------------------------------------------------------------
-- Basic
-------------------------------------------------------------------------------
vim.o.fenc = 'utf-8' -- set file encording to UTF-8
-- do not make buckup file or swapfile
vim.o.backup = false
vim.o.swapfile = false
vim.o.hidden = true -- enable to open another file when edditing
vim.o.mouse = 'a' -- enable mouse
vim.o.clipboard = 'unnamedplus' -- yank to clipboard
vim.api.nvim_command('source $VIMRUNTIME/macros/matchit.vim') -- enable to jump HTML tag by %
vim.api.nvim_command('set isk+=-') -- interpret words chained by `-` as one word
vim.o.wrap = false -- do not wrap long line

-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
vim.o.number = true -- show line number
vim.o.virtualedit = 'onemore' -- enable to move cursor to one more forward to last word of the line
vim.o.smartindent = true -- auto indent for programming
vim.o.showmatch = true -- show ) when input (
vim.o.wildmode = 'list:longest' -- autocomplete in command line
vim.o.laststatus = 2 -- show statusline

-------------------------------------------------------------------------------
-- keymap
-------------------------------------------------------------------------------
vim.api.nvim_set_keymap('n', ';', ':', {noremap = true})
vim.api.nvim_set_keymap('n', 'm', 'q', {noremap = true}) -- m : macro
vim.api.nvim_set_keymap('', 'q', '$', {noremap = true}) -- q : move to end of the line
vim.api.nvim_set_keymap('', 'H', '^', {noremap = true}) -- H : move to top of the line

-- Avoid yank
for _, each_mode in pairs({'n', 'v'}) do
  for _, each_command in pairs({'c', 'C', 'd', 'D'}) do
    vim.api.nvim_set_keymap(each_mode, each_command, '"_' .. each_command, {noremap = true})
  end
end
vim.api.nvim_set_keymap('v', 'p', '"_dP', {noremap = true})

-- moves in insert mode
vim.api.nvim_set_keymap('i', '<C-a>', '<Home>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-d>', '<Right><BS>', {noremap = true})
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Space>q', ':qa!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<M-a>', 'ggVG', {noremap = true})

-- enable to omit `i` eg. c(i)w
for _, each_command in pairs({'c', 'd', 'v', 'y'}) do
  for _, each_target in pairs({'(', ')', '{', '}', '[', ']', '"', '`', "'", 'w', 't'}) do
    vim.api.nvim_set_keymap('n', each_command .. each_target, each_command .. 'i' .. each_target, {})
  end
end

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use {'wbthomason/packer.nvim', opt = true}

  use 'jiangmiao/auto-pairs'
  use {'tomasiser/vim-code-dark', opt = true}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-------------------------------------------------------------------------------
-- Colors
-------------------------------------------------------------------------------
vim.api.nvim_command('colorscheme codedark')
vim.api.nvim_command('highlight Search ctermbg=24') -- hitting words
vim.api.nvim_command('highlight IncSearch ctermbg=34') -- replace target
