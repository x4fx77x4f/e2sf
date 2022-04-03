return function(instance, env)
	local entity_meta = instance:new_type("entity", "e")
	local NULL = entity(-1)
	function entity_meta:new_default()
		return instance:wrap(NULL, entity_meta)
	end
	local entity_methods = entity_meta.__index
	local function getent(wrapped, allow_invalid)
		local unwrapped = instance:unwrap(wrapped, entity_meta)
		if not isValid(unwrapped) and not allow_invalid then
			error("Invalid entity!", 3)
		end
		return unwrapped
	end
	entity_meta.getent = getent
	local function getphys(ent)
		local phys = ent:getPhysicsObject()
		if not isValid(phys) then
			error("Invalid physics object!", 3)
		end
		return phys
	end
	entity_meta.getphys = getphys
	function entity_meta:__tostring()
		self = getent(self, true)
		return isValid(self) and tostring(self) or "(null)"
	end
	entity_meta.NULL = NULL
	
	function env.entity(entindex)
		return instance:wrap(entindex ~= nil and entity(entindex) or instance.entity or NULL, entity_meta)
	end
	function env.noentity()
		return instance:wrap(NULL, entity_meta)
	end
	function env.world()
		return instance:wrap(game.getWorld(), entity_meta)
	end
	--function env.sunDirection() end
	function env.setMass(mass)
		return self.entity:setMass(math.clamp(mass, 0.001, 50000))
	end
	
	function entity_methods:id()
		return getent(self):entIndex()
	end
	function entity_methods:creationID()
		return getent(self):getCreationID()
	end
	function entity_methods:creationTime()
		return getent(self):getCreationTime()
	end
	function entity_methods:name()
		self = getent(self)
		return self.getName and self:getName() or ""
	end
	function entity_methods:type()
		return getent(self):getClass()
	end
	function entity_methods:model()
		return getent(self):getModel()
	end
	function entity_methods:owner()
		return instance:wrap(getent(self):getOwner(), entity_meta)
	end
	--function entity_methods:keyvalues() end
	--function entity_methods:pos() end
	--function entity_methods:forward() end
	--function entity_methods:right() end
	--function entity_methods:up() end
	--function entity_methods:vel() end
	--function entity_methods:velL() end
	--function entity_methods:angVel() end
	--function entity_methods:angVelVector() end
	--function entity_methods:toWorld(local) end
	--function entity_methods:toLocal(world) end
	--function entity_methods:toWorldAxis(local) end
	--function entity_methods:toLocalAxis(world) end
	function entity_methods:health()
		return getent(self):getHealth()
	end
	function entity_methods:maxHealth()
		return getent(self):getMaxHealth()
	end
	--function entity_methods:radius() return getent(self):getBoundingRadius() end -- For some reason Entity:BoundingRadius is not exposed to SF!?
	--function entity_methods:bearing(pos) end
	--function entity_methods:elevation(pos) end
	--function entity_methods:heading(pos) end
	function entity_methods:mass()
		return getent(self):getMass()
	end
	function entity_methods:massCenter()
		return getent(self):getMassCenterW()
	end
	function entity_methods:massCenterL()
		return getent(self):getMassCenter()
	end
	function entity_methods:setMass(mass)
		return getent(self):setMass(math.clamp(mass, 0.001, 50000))
	end
	function entity_methods:volume()
		return getphys(getent(self)):getVolume() or 0
	end
	--function entity_methods:surfaceArea() return getphys(getent(self)):getSurfaceArea() or 0 end
	--function entity_methods:stress() return getphys(getent(self)):getStress() or 0 end
	--function entity_methods:frictionSnapshot() end
	function entity_methods:isPlayer()
		return getent(self):isPlayer() and 1 or 0
	end
	function entity_methods:isNPC()
		return getent(self):isNPC() and 1 or 0
	end
	function entity_methods:isVehicle()
		return getent(self):isVehicle() and 1 or 0
	end
	function entity_methods:isWorld()
		return getent(self) == game.getWorld() and 1 or 0
	end
	function entity_methods:isOnGround()
		return getent(self):isOnGround() and 1 or 0
	end
	function entity_methods:isUnderWater()
		return getent(self):getWaterLevel() > 0 and 1 or 0
	end
	function entity_methods:isValid()
		return isValid(getent(self, true)) and 1 or 0
	end
	--function entity_methods:isValidPhysics() end
	--function entity_methods:angles() end
	function entity_methods:getMaterial()
		return getent(self):getMaterial() or ''
	end
	function entity_methods:getSubMaterial(index)
		return getent(self):getSubMaterial(index-1) or ''
	end
	--function entity_methods:getMaterials() end
	function entity_methods:getSkin()
		return getent(self):getSkin()
	end
	function entity_methods:setSkin(index)
		self = getent(self)
		if self:isPlayer() then
			error("You cannot set the skin of a player!", 2)
		end
		local skin_count = self:getSkinCount()
		if skin_count > 0 and index < skin_count then
			self:setSkin(index)
		end
	end
	function entity_methods:getSkinCount()
		return getent(self):getSkinCount()
	end
	function entity_methods:setBodygroup(bodygroup, value)
		self = getent(self)
		if self:getOwner() ~= self.owner then
			error("You do not own this entity!", 2)
		end
		self:setBodygroup(bodygroup, value)
	end
	function entity_methods:getBodygroup(bodygroup)
		return getent(self):getBodygroup(bodygroup)
	end
	--function entity_methods:getBodygroups() return getent(self):getBodygroupCount() end
	function entity_methods:isPlayerHolding()
		return getent(self):isPlayerHolding() and 1 or 0
	end
	function entity_methods:isOnFire()
		return getent(self):isOnFire() and 1 or 0
	end
	function entity_methods:isWeapon()
		return getent(self):isWeapon() and 1 or 0
	end
	function entity_methods:isFrozen()
		return getent(self):isFrozen() and 1 or 0
	end
	--function entity_methods:applyForce(force) end
	--function entity_methods:applyOffsetForce(force, pos) end
	--function entity_methods:applyAngForce(angForce) end
	--function entity_methods:applyTorque(torque) end
	--function entity_methods:inertia() end
	function entity_methods:lockPod(lock)
		self = getent(self)
		if self:getOwner() ~= self.owner then
			error("You do not own this entity!", 2)
		end
		if lock ~= 0 then
			self:lock()
		else
			self:unlock()
		end
	end
	function entity_methods:killPod()
		self = getent(self)
		if self:getOwner() ~= self.owner then
			error("You do not own this entity!", 2)
		end
		self:killDriver()
	end
	function entity_methods:ejectPod()
		self = getent(self)
		if self:getOwner() ~= self.owner then
			error("You do not own this entity!", 2)
		end
		self:ejectDriver()
	end
	function entity_methods:podStripWeapons()
		self = getent(self)
		if self:getOwner() ~= self.owner then
			error("You do not own this entity!", 2)
		end
		local driver = self:getDriver()
		if isValid(driver) and next(driver:getWeapons()) ~= nil then
			self:stripDriver()
			instance:print_target(driver, "Your weapons have been stripped!")
		end
	end
	--function entity_methods:boxSize() end
	--function entity_methods:boxCenter() end
	--function entity_methods:boxCenterW() end
	--function entity_methods:boxMax() end
	--function entity_methods:boxMin() end
	--function entity_methods:aabbMin() end
	--function entity_methods:aabbMax() end
	--function entity_methods:aabbSize() end
	--function entity_methods:aabbWorldMin() end
	--function entity_methods:aabbWorldMax() end
	--function entity_methods:aabbWorldSize() end
	--function entity_methods:driver() end
	--function entity_methods:passenger() end
	entity_methods.tostring = entity_meta.__tostring
	--function entity_methods:removeTrails() end
	--function entity_methods:setTrails(startSize, endSize, length, material, color, alpha, attachmentID, additive) end
	function entity_methods:lookupAttachment(name)
		return getent(self):lookupAttachment(name)
	end
	--function entity_methods:attachmentPos(attachmentID) end
	--function entity_methods:attachmentAng(attachmentID) end
	--function entity_methods:attachments() end
	--function entity_methods:nearestPoint() end
end
