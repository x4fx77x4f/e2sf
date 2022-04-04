return function(instance, env)
	local clk_first = instance:new_clk('first', true)
	function env.first()
		return clk_first._running and 1 or 0
	end
	local clk_duped = instance:new_clk('duped', true)
	function env.duped()
		return clk_duped._running and 1 or 0
	end
	--function env.inputClk() end
	--function env.inputClkName() end
	local clk_last = instance:new_clk('last', false)
	function env.last()
		return clk_last._running and 1 or 0
	end
	--function env.dupefinished() end
	env.removing = env.last
	function env.runOnLast(bool)
		clk_last._enabled = bool ~= 0
	end
	function env.exit()
		error("exit")
	end
	function env.error(reason)
		error(reason, 2)
	end
	function env.assert(condition, reason)
		if condition == 0 then
			error(reason or "assert failed", 2)
		end
	end
	--function env.reset() end
	--function env.ops() end
	--function env.opcounter() end
	--function env.cpuUsage() end
	--function env.perf(n) end
	--function env.minquota(n) end
	--function env.maxquota(n) end
	--function env.softQuota(n) end
	--function env.hardQuota(n) end
	--function env.timeQuota(n) end
	env.select = select
end
