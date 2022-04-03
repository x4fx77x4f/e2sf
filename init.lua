--@name Expression 2 emulator
--@server
--@include ./cl_egp3.lua
--@clientmain ./cl_egp3.lua

--@include ./runtime/init.lua
local runtime = dofile('./runtime/init.lua')

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
e2.ready = true
e2:run_main()
