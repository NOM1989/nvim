require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- mouse users + nvimtree users!
map({ "n", "v" }, "<RightMouse>", function()
  require("menu.utils").delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})

-- load the session for the current directory
map("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Restore Session" })

-- Floating diagnostic
map("n", "ff", function()
  vim.diagnostic.open_float { border = "rounded", close_events = { "CursorMoved" } }
end, { desc = "Floating diagnostic" })

-- Move line(s)
map("n", "<A-Up>", "ddkP", {desc = "Move line up"} )
map("n", "<A-Down>", "ddp", {desc = "Move line down"} )
map("v", "<A-Up>", ":m-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-Down>", ":m'>+<CR>gv=gv", { desc = "Move line down" })

map("i", "<C-BS>", "<C-w>", { desc = "Delete word" })

-- Change windows
map("n", "<leader><leader>", "<C-W><C-W>", { desc = "Previous window" })

-- Make :Q and :Qa behave like :q and :qa
vim.cmd('cnoreabbrev Q q')
vim.cmd('cnoreabbrev Qa qa')

-- Toggle wrap
map("n", "<leader>z", ":set wrap!<CR>", { desc = "Toggle wrap" })

-- Ease navigation in long wrapped lines
map("n", "<Up>", "gk", { desc = "Navigate display line up" })
map("n", "<Down>", "gj", { desc = "Navigate display line down" })

-- Handle multiple cursors
-- v0.13 repurposed <C-LeftMouse> from "LSP go to definition" (via tagfunc)
-- to "toggle multicursor". Move multicursor to <C-S-LeftMouse> and restore
-- <C-LeftMouse> to jump-to-definition.
map("n", "<C-LeftMouse>", function()
  local pos = vim.fn.getmousepos()
  if pos.winid == 0 then
    return
  end
  vim.api.nvim_set_current_win(pos.winid)
  vim.api.nvim_win_set_cursor(pos.winid, { pos.line, math.max(pos.column - 1, 0) })
  vim.lsp.buf.definition()
end, { desc = "LSP go to definition (Ctrl-click)" })

-- remap = false (noremap) sends the raw key through *without* re-running
-- user mappings, so this falls through to the builtin multicursor toggle
-- instead of recursing into the override above.
-- map("n", "<C-S-LeftMouse>", "<C-LeftMouse>", { desc = "Toggle multicursor (Ctrl-Shift-click)", remap = false })
