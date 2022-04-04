--@name Expression 2 emulator
--@model models/beer/wiremod/gate_e2.mdl
--@server
--@include ./cl_init.lua
--@clientmain ./cl_init.lua

xpcall(function() -- Work around https://github.com/thegrb93/StarfallEx/issues/1295

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
e2:add_precompiled('csgo_caseopener.txt', getScripts()[path], true)
e2:run_first()

end, function(err, st)
	timer.simple(0, function()
		printConsole(st)
	end)
end)
