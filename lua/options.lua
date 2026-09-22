require "nvchad.options"

local o = vim.o

o.number = true
o.relativenumber = true

o.scrolloff = 7

local g = vim.g
if g.neovide then
  -- Put anything you want to happen only in Neovide here
  o.guifont = "JetBrains Mono:h16"
end

local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor to Beam (blinking) on leave.
autocmd({ 'VimLeave', 'VimSuspend' }, {
  pattern = { '*' },
  callback = function()
    o.guicursor = "a:ver100,a:blinkon1"
  end
})

o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal"

o.winborder = "rounded"
