return function(instance, env)
	local array_meta = instance:new_type("array", "a")
	function array_meta:new_default()
		return instance:wrap({}, array_meta)
	end
	
	function env.array(...)
		return instance:wrap({...}, array_meta)
	end
end
