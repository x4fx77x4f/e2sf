return function(self, env)
	function self:run_timers()
		local timers = self.timers
		local now = timer.curtime()
		for name, time in pairs(timers) do
			if now >= time then
				self.clk_name = name
				self:run_main()
				timers[name] = nil -- TODO: Is it safe to remove an element from an unordered table while iterating over it with 'pairs'?
			end
		end
	end
	
	local function guest_timer(name, delay)
		delay = math.max(delay, 10)/1000
		self.timers[name] = timer.curtime()+delay
	end
	env.timer = timer
	function env.interval(delay)
		return guest_timer('interval', delay)
	end
	function env.clk(name)
		return (self.clk_name == (name or 'interval')) and 1 or 0
	end
	function env.clkName()
		return self.clk_name
	end
	function env.getTimers()
		local array, i = {}, 1
		for name in pairs(self.timers) do
			array[i] = name
			i = i+1
		end
		return array
	end
	function env.stopAllTimers()
		local timers = self.timers
		for name in pairs(timers) do
			timers[name] = nil
		end
	end
	env.curtime = timer.curtime
	env.realtime = timer.realtime
	env.systime = timer.systime
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
	function env.time(data)
		if type(data) == 'string' then
			return os.date('*t')[data]
		end
		return os.time(data)
	end
end
