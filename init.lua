--@name Expression 2 emulator
--@server
--@include ./cl_egp3.lua
--@clientmain ./cl_egp3.lua

timer.simple(0, function() -- Work around https://github.com/thegrb93/StarfallEx/issues/1295

--@include ./sv_runtime.lua
local runtime = dofile('./sv_runtime.lua')

local e2 = runtime:new()
e2:build_environment()
--@includedata ./expression2/csgo_caseopener.lua
local path
for k in pairs(getScripts()) do
	if string.find(k, '/csgo_caseopener%.lua$') then
		path = k
	end
end
assert(path)
e2:compile('csgo_caseopener.txt', getScripts()[path], true)
e2:run_first()

end)
