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
		types = {},
		unwrapped = setmetatable({}, {__mode='k'}),
		wrapped = setmetatable({}, {__mode='v'}),
		entity = chip and chip() or nil,
		owner = owner and owner() or nil,
		ready = false,
		clk = {},
	}
	obj.identifier = identifier or table.address(obj)
	return setmetatable(obj, self or runtime)
end

runtime.print_prefix_color = Color(255, 63, 63)
runtime.print_prefix = string.format("[%s] ", chip and chip():entIndex() or "nil")
runtime.print_color = Color(152, 212, 255)
function runtime:print_target(ply, ...)
	if ply == self.owner then
		print(self.print_prefix_color, self.print_prefix, self.print_color, ...)
		return true
	end
	return pcall(printHud, ply, self.print_prefix_color, self.print_prefix, self.print_color, ...)
end

function runtime:new_type(name)
	local msg = string.format("attempt to index a %s value", name)
	local meta = {
		__index = {},
		__newindex = function(self, k, v)
			return error(name)
		end,
		__metatable = name,
	}
	self.types[name] = meta
	return meta
end
function runtime:wrap(unwrapped, meta)
	local wrapped = self.wrapped[unwrapped]
	if not wrapped then
		wrapped = setmetatable({}, meta)
		self.unwrapped[wrapped] = unwrapped
		self.unwrapped[unwrapped] = wrapped
	end
	return wrapped
end
function runtime:unwrap(wrapped)
	return self.unwrapped[wrapped]
end
function runtime:new_clk(name, default)
	local data = {
		_enabled = not not default,
		_running = false,
	}
	self.clk[name] = data
	return data
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
	
	-- Bare expressions are okay in E2, so we need this to deal with them.
	function env._nop() end
	
	-- Methods can be used on nil values in E2, and string methods may be impossible to implement normally, so we need to allow methods to be obtained in another way.
	function env._method(name, k)
		return self.types[name].__index[k]
	end
	
	local hooks = {}
	--@includedir ./core/
	for path, func in pairs(dodir('./core/')) do
		local hook = func(self, env)
		if hook then
			table.insert(hooks, hook)
		end
	end
	for k=1, #hooks do
		hooks[k]()
	end
	
	return env
end
function runtime:setup_persist_defaults(tbl)
	local env = self.env
	for k, vt in pairs(tbl) do
		local v
		if vt == 'number' then
			v = 0
		elseif vt == 'string' then
			v = ''
		else
			v = self.types[vt]:new_default()
		end
		self.env[k] = v
	end
end
function runtime:setup_inputs(inputs)
	self.inputs = inputs
	wire.adjustPorts(inputs, nil)
end
function runtime:setup_inputs_fake(inputs)
	self.inputs_fake = inputs
end
function runtime:setup_outputs(outputs)
	self.outputs = outputs
	wire.adjustPorts(nil, outputs)
end
function runtime:setup_outputs_fake(outputs)
	return self:setup_persist_defaults(outputs)
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
function runtime.xpcall_callback(err, st)
	if type(err) == 'table' then
		err = err.message
	end
	err = tostring(err)
	st = st or debug.traceback(err, 2)
	return err, st
end
function runtime:run(func, ...)
	local retvals = {xpcall(func, self.xpcall_callback, ...)}
	if not retvals[1] then
		print("### E2SF runtime error ###\n"..retvals[3])
		self.ready = false
	end
	return unpack(retvals)
end
function runtime:run_main()
	local ports = wire.ports
	for k, vt in pairs(self.inputs) do
		local v = ports[k]
		assert(v, vt)
		if vt ~= 'number' and vt ~= 'string' then
			v = self:wrap(v, self.types[vt])
		end
		rawset(self.env, k, v)
	end
	local success = self:run(self.includes[self.mainfile])
	return success
end
function runtime:run_clk(name)
	local data = self.clk[name]
	if data._enabled then
		data._running = true
		local success = self:run_main()
		data._running = false
		return success
	end
end
function runtime:run_first()
	self.ready = true
	return self:run_clk('first')
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
