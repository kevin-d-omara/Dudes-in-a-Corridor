--[[
A collection of file i/o facilities.

== From ==
http://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
http://lua-users.org/wiki/FileInputOutput
--]]

-- see if the file exists
function fileExists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file; returns an empty table if file is non existant
function linesFrom(file)
  if not fileExists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end