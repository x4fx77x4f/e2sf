-- If Starfall ever changes how string methods are handled, it could allow for a sandbox escape.
if not _ALLOW_UNSAFE_STRING_METHODS then
	local test = {}
	string[test] = true
	assert(not ('')[test])
	string[test] = nil
end

local runtime = {}
runtime.__index = runtime
function runtime:new(identifier)
	local obj = {
		includes = {},
		timers = {},
		types = {},
	}
	obj.identifier = identifier or table.address(obj)
	return setmetatable(obj, self or runtime)
end

function runtime:build_environment()
	local env = {}
	if self then
		self.env = env
	end
	env._G = env
	
	-- Basic syntax
	function env._switch(var, cases, ...)
		local fallthrough = false
		for k=1, #cases do
			local v = cases[k]
			local case = v[1]
			if fallthrough or case == var or not case then
				if v[2](...) then
					return
				end
				fallthrough = true
			end
		end
	end
	
	env._try = pcall
	env._try_catch = xpcall
	
	local _foreach_continue = {}
	env._foreach_continue = _continue
	local _foreach_break = {}
	env._foreach_break = _break
	function env._foreach(ktype, vtype, tbl, func)
		error("TODO")
	end
	
	function env._nop() end -- Bare expressions are okay in E2, so we need this to deal with them.
	
	--@include ./array.lua
	require('./array.lua')(self, env)
	--@include ./bitwise.lua
	require('./bitwise.lua')(self, env)
	--@include ./timer.lua
	require('./timer.lua')(self, env)
	
	return env
end

function runtime:compile(path, func, main)
	if type(func) == 'string' then
		local err
		func, err = loadstring(func, string.format("%s:%s", self.identifier, path))
		if type(func) == 'string' then
			func, err = nil, func
		end
		assert(func, err)
	end
	setfenv(func, self.env)
	self.includes[path] = func
	if main then
		self.mainfile = path
	end
	return func
end

function runtime:run_main()
	self:run(self.includes[self.mainfile])
end

function runtime:run(func)
	func()
end

-- Datatypes
-- n = number
-- v2 = vector2
-- v = vector
-- v4 = vector4
-- a = angle
-- s = string
-- e = entity
-- a = array
-- t = table
-- rd = Ranger Data (???)
-- b = bone
-- m2 = matrix2
-- m = matrix
-- m4 = matrix4
-- xwl = wirelink
-- c = complex
-- q = quaternion
-- xtd = tracedata
-- r = ranger
-- xgt = gtable
-- xft = ftrace
-- xsc = stcontrol
-- xdm = damage

return runtime
