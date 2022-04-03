return function(instance, env)
	local clk_timer = instance:new_clk('timer')
	local timers = {}
	instance.timers = timers
	function instance:run_timers()
		local now = timer.curtime()
		for name, time in pairs(timers) do
			if now >= time then
				clk_timer.name = name
				instance:run_clk('timer')
				timers[name] = nil -- TODO: Is it safe to remove an element from an unordered table while iterating over it with 'pairs'?
			end
		end
	end
	
	local function add_timer(name, delay)
		delay = math.max(delay, 10)/1000
		timers[name] = timer.curtime()+delay
	end
	function env.interval(delay)
		return add_timer('interval', delay)
	end
	env.timer = add_timer
	function env.stoptimer(name)
		timers[name] = nil
	end
	function env.clk(name)
		return (clk_timer.name == (name or 'interval')) and 1 or 0
	end
	function env.clkName()
		return clk_timer.name
	end
	function env.getTimers()
		local array, i = {}, 1
		for name in pairs(timers) do
			array[i] = name
			i = i+1
		end
		return array
	end
	function env.stopAllTimers()
		for name in pairs(timers) do
			timers[name] = nil
		end
	end
	env.curtime = timer.curtime
	env.realtime = timer.realtime
	env.systime = timer.systime
	--[[
	function env.date(time)
		local data = os.date('*t', time)
		data.isdst = data.isdst and 1 or 0
		return data
	end
	function env.dateUTC(time)
		local data = os.date('!*t', time)
		data.isdst = data.isdst and 1 or 0
		return data
	end
	]]
	local validkeys = {
		hour = true,
		min = true,
		day = true,
		sec = true,
		yday = true,
		wday = true,
		month = true,
		year = true,
		isdst = true,
	}
	function env.time(data)
		if type(data) == 'string' then
			local ret = os.date('!*t')[data]
			return tonumber(ret) or ret and 1 or 0
		end
		error("not implemented")
		local args = {}
		data = instance:unwrap(data)
		for k, v in pairs(data.s) do
			if data.stypes[k] == 'n' and validkeys[k] then
				if k == 'isdst' then
					args[k] = k == 1 -- Shouldn't this be 'k ~= 1'?
				else
					args[k] = v
				end
			end
		end
		return os.time(args)
	end
end
