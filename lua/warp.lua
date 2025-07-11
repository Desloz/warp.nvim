local function notify(message)
    require("snacks").notify(message)
end

local action = {}

action.jump = function(path)
  local previous = vim.fn.getcwd()

  vim.cmd("cd " .. path)

  local current = vim.fn.getcwd()

  if current == previous then
    notify("already at " .. current)
  else
    notify(previous .. " -> " .. current)
  end
end

action.open_external_terminal = function(path)
  local terminal = os.getenv("TERM")
  local path = vim.fn.expand(path)
  local command = terminal .. " " .. "--working-directory" .. " " .. path .. " &"
  os.execute(command)
end

action.yank = function(text)
  local text = vim.fn.expand(text)
  require("snacks").notify("Copied to clipboard '" .. text .. "'")
  vim.fn.setreg("+", text)
end

action.print = function(message)
  notify(message)
end

local finder = {}

finder.home_directory = function()
  return vim.fn.expand("~")
end

finder.parent_directory = function()
  return vim.fn.expand("%:p:h:h")
end

finder.file_directory = function()
  return vim.fn.expand("%:p:h")
end

finder.file_path = function()
  return vim.fn.expand("%:p")
end

finder.working_directory = function()
  return vim.fn.getcwd()
end

local M = {}

M.execute = function(action, finder)
  local source = finder()
  action(source)
end

M.create_executer = function(action, finder)
  return function()
    return M.execute(action, finder)
  end
end

M.action = action
M.finder = finder

M.setup = function()
end

return M