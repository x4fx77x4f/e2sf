return function(instance, env)
	function env.playerCanPrint()
		return 1
	end
	local HUD = HUD or {
		PRINTCENTER = 1,
		PRINTCONSOLE = 2,
		PRINTNOTIFY = 3,
		PRINTTALK = 4,
	}
	local valid_message_types = {
		[HUD.PRINTCENTER] = true,
		[HUD.PRINTCONSOLE] = true,
		[HUD.PRINTNOTIFY] = true,
		[HUD.PRINTTALK] = true,
	}
	env._HUD_PRINTCENTER = HUD.PRINTCENTER
	env._HUD_PRINTCONSOLE = HUD.PRINTCONSOLE
	env._HUD_PRINTNOTIFY = HUD.PRINTNOTIFY
	env._HUD_PRINTTALK = HUD.PRINTTALK
	function env.print(message_type, text, ...)
		if not isValid(instance.owner) then
			return
		end
		if type(message_type) == 'number' and type(text) == 'string' then
			if not valid_message_types[message_type] then
				return
			end
			text = string.sub(text, 1, 249)
			net.start('print')
				net.writeUInt(message_type, 8)
				net.writeUInt(#text, 8)
				net.writeData(text)
			net.send(instance.owner)
		end
		return instance:print_target(instance.owner, message_type, text, ...)
	end
	function env.hint(text, duration)
		if not isValid(instance.owner) then
			return
		end
		text = string.sub(text, 1, 249)
		duration = math.clamp(duration, 0.7, 7)
		net.start('hint')
			net.writeUInt(#text, 8)
			net.writeData(text)
			net.writeDouble(duration)
		net.send(instance.owner)
	end
	
	return function()
		local entity_meta = instance.types.entity
		local entity_methods = entity_meta.__index
		local getent = entity_meta.getent
		
		function entity_methods:printDriver(message_type, text)
			self = getent(self)
			if not self:isVehicle() then
				error("Expected Vehicle, got Entity", 2)
			elseif self:getOwner() ~= instance.owner then
				error("You do not own this vehicle!", 2)
			end
			local driver = self:getDriver()
			if not isValid(driver) then
				return 0
			end
			if type(message_type) == 'number' then
				if not valid_message_types[message_type] then
					return
				end
				text = string.sub(text, 1, 249)
				net.start('print')
					net.writeUInt(message_type, 8)
					net.writeUInt(#text, 8)
					net.writeData(text)
				net.send(driver)
				return 1
			else
				return instance:print_target(driver, string.sub(message_type, 1, 249)) and 1 or 0
			end
		end
		function entity_methods:hintDriver(text, duration)
			self = getent(self)
			if not self:isVehicle() then
				error("Expected Vehicle, got Entity", 2)
			elseif self:getOwner() ~= instance.owner then
				error("You do not own this vehicle!", 2)
			end
			local driver = self:getDriver()
			if not isValid(driver) then
				return 0
			end
			text = string.sub(text, 1, 249)
			duration = math.clamp(duration, 0.7, 7)
			net.start('hint')
				net.writeUInt(#text, 8)
				net.writeData(text)
				net.writeDouble(duration)
			net.send(driver)
			return 1
		end
	end
end
