return function(self, env)
	local array = {}
	self.types.array = array
	array.__index = {}
	function array:new(...)
		return setmetatable({...}, self or array)
	end
	
	function env.array(...)
		return array:new(...)
	end
end
