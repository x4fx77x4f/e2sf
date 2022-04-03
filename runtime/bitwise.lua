return function(instance, env)
	env.bAnd = bit.band
	env.bOr = bit.bor
	env.bXor = bit.bxor
	env.bShr = bit.brshift
	env.bShl = bit.blshift
	local bit_bnot = bit.bnot
	function env.bNot(n, bits)
		if bits == nil then
			return bit_bnot(n)
		elseif bits >= 32 or bits < 1 then
			return (-1)-n
		else
			return (math.pow(2, bits)-1)-n
		end
	end
end
