return function(self, env)
	local entity = {}
	self.types.entity = entity
	entity.__index = {}
	function entity:new(entindex)
		return setmetatable({}, self or entity)
	end
	
	function entity:unwrap()
		
	end
	
	function env.entity(entindex)
		return entity:new(entindex)
	end
end

