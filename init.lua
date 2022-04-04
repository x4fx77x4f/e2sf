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
e2:compile('csgo_caseopener.txt', getScripts()[path], true)
e2:setup_inputs({
	--EGP = 'wirelink',
	--EGP2 = 'wirelink', -- unused
	User = 'entity',
})
e2:setup_outputs({
	X = 'number',
	Y = 'number',
	Kage = 'string',
})
e2:setup_persist_defaults({
	O = 'number',
	Time = 'number',
	Array = 'array',
	Temp = 'number',
	PriceArray = 'array',
	Player = 'entity',
	SideA = 'number',
	SideB = 'number',
	Money = 'number',
	MoneyOld = 'number',
	BaseHeight = 'number',
	ABlock = 'number',
	BBlock = 'number',
	CBlock = 'number',
	DBlock = 'number',
	Speed = 'number',
	Random = 'number',
	KeyPrice = 'number',
	First = 'number',
	AItem = 'string',
	AMaterial = 'string',
	BItem = 'string',
	BMaterial = 'string',
	CItem = 'string',
	CMaterial = 'string',
	DItem = 'string',
	DMaterial = 'string',
	Paid = 'number',
})
e2:run_first()

end, function(err, st)
	timer.simple(0, function()
		printConsole(st)
	end)
end)
