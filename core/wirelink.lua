return function(instance, env)
	local wirelink_meta = instance:new_type("wirelink", "xwl")
	local NULL = {}
	function wirelink_meta:new_default()
		return instance:wrap(NULL, wirelink_meta)
	end
	local wirelink_methods = wirelink_meta.__index
	local function getwl(wrapped)
		local unwrapped = instance:unwrap(wrapped, entity_meta)
		if isValid(unwrapped) and unwrapped:entity():getOwner() == instance.owner then
			return unwrapped
		end
	end
	wirelink_meta.getwl = getwl
	wirelink_meta.NULL = NULL
	
	function env.wirelink()
		return instance:wrap(wire.self(), wirelink_meta)
	end
	function env.nowirelink()
		return instance:wrap(NULL, wirelink_meta)
	end
	
	--function wirelink_methods:isHiSpeed(portname) end
	--function wirelink_methods:hasInput(portname) end
	--function wirelink_methods:hasOutput(portname) end
	--function wirelink_methods:setXyz() end
	--function wirelink_methods:xyz() end
	--function wirelink_methods:inputs() end
	--function wirelink_methods:outputs() end
	--function wirelink_methods:inputType(input) end
	--function wirelink_methods:outputType(output) end
	--function wirelink_methods:writeCell(address, value) end
	--function wirelink_methods:readCell(address) end
	
	return function()
		local entity_meta = instance.types.entity
		local entity_methods = entity_meta.__index
		
		function wirelink_methods:entity()
			self = getwl(self)
			return instance:wrap(isValid(self) and self or entity_meta.NULL, entity_meta)
		end
	end
end
