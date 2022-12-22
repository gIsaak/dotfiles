-- Terminal funcionality
local M = {}

local term_buf = nil
local term_win = nil

-- Toggle a split window running a terminal buffer at the bottom of the screen
-- Souce python virtual environment if present
M.term_toggle = function(height)
  if term_win ~= nil and vim.fn.win_gotoid(term_win) then
    if pcall(vim.cmd, 'hide') then
      return
    end
  end

  vim.cmd 'botright new'
  vim.cmd('resize ' .. height)

  if term_buf == nil or not pcall(vim.cmd, 'buffer ' .. term_buf) then
    vim.fn.termopen(vim.env.SHELL, { detach = 0 })
    term_buf = vim.fn.bufnr()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = 'no'
    if vim.fn.exists("$VIRTUAL_ENV") ~= 0 then
      vim.fn.chansend(vim.b.terminal_job_id, "source $VIRTUAL_ENV/bin/activate && clear\n")
    end
  end
  vim.cmd 'startinsert!'

  term_win = vim.fn.win_getid()
end

-- Ececute external command, expected as string, inside the terminal window
M.term_execute = function(ext_cmd)
    if vim.fn.win_gotoid(term_win) == 0 then
      M.term_toggle(10)
      end
    vim.fn.chansend(vim.b.terminal_job_id, ext_cmd)
end

-- TODO Clean terminal
-- M.term_clean = function()
--     vim.api.nvim_feedkeys("clear", "t", false)
-- end

-- Run script in python interpreter
local python_run = function()
    local sub = vim.fn.substitute
    local filename = sub(vim.fn.expand("%"), ".py", "", "")
    M.term_execute("python\n")
    M.term_execute("import " .. sub(filename, "/", ".", "") .. "\n")
end

-- Run script in julia REPL
local julia_run = function()
    local filename = vim.fn.expand("%")
    M.term_execute("julia\n")
    M.term_execute('include("' .. filename .. '")\n')
end

-- table of configured repls
local repls = {
    ["python"] = python_run,
    ["julia"] = julia_run
}

-- Run script in REPL based of filetype
M.repl_execute = function()
    local filetype = vim.bo.filetype
    for lang, func in pairs(repls) do
        if filetype == lang then
            func()
        end
    end
end

return M

