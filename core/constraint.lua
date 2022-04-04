return function(instance, env, post)
	return function()
		local entity_meta = instance.types.entity
		local entity_methods = entity_meta.__index
		local getent = entity_meta.getent
		local NULL = entity_meta.NULL
		
		--function entity_methods:getConstraints() end
		--function entity_methods:getConnectedEntities(filters, ...) end
		--function entity_methods:hasConstraints(constraintType) end
		--function entity_methods:isConstrained() end
		function entity_methods:isWeldedTo(index)
			assert(not index, "not implemented")
			return instance:wrap(getent(self):isWeldedTo() or NULL, entity_meta)
		end
		--function entity_methods:isConstrainedTo(constraintType, index) end
		--function entity_methods:parent() end
		--function entity_methods:parentBone() end
		--function entity_methods:children() end
	end
end
