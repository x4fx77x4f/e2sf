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
--@includedir ./expression2/
local path, code = '/e2sf_test.lua'
for k, v in pairs(getScripts()) do
	if string.sub(k, -#path) == path then
		path = string.gsub(path, '^/', '')
		path = string.gsub(path, '%.lua$', '.txt')
		code = v
	end
end
e2:add_precompiled(path, code, true)
e2:run_first()

end, function(err, st)
	timer.simple(0, function()
		printConsole(st)
	end)
end)
