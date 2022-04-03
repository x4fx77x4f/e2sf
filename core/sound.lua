return function(instance, env)
	-- Stub for now
	function env.soundPlay(index, duration, path, fade)
		fade = fade or 0
	end
	function env.soundStop(index, fadetime)
		fadetime = fadetime or 0
	end
	function env.soundVolume(index, volume, fadetime)
		fadetime = fadetime or 0
	end
	function env.soundPitch(index, volume, fadetime)
		fadetime = fadetime or 0
	end
	function env.soundPurge() end
	function env.soundDuration(sound)
		return sounds.duration(sound) or 0
	end
	
	return function()
		local entity_meta = instance.types.entity
		local entity_methods = entity_meta.__index
		local getent = entity_meta.getent
		
		function entity_methods:soundPlay(index, duration, path, fade)
			self = getent(self)
			if self:getOwner() ~= self.owner then
				error("You do not own this entity!", 2)
			end
			fade = fade or 0
		end
	end
end
