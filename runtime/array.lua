return function(instance, env)
	local array_meta = instance:new_type("array", "a")
	
	function env.array(...)
		return instance:wrap({...}, array_meta)
	end
end
