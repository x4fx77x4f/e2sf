return function(instance, env)
	-- This is not a normal type. Normal Lua numbers are used instead of wrappers.
	local number_meta = instance:new_type("number", "n")
	function number_meta:new_default()
		return 0
	end
	local number_methods = number_meta.__index
	
	local pi = math.pi
	env.PI = pi
	local e = math.exp(1)
	env.E = e
	env.PHI = (1+math.sqrt(5))/2
	
	env.min = math.min
	env.max = math.max
	local inf = math.huge
	function env.isfinite(n)
		return (n ~= inf and n ~= inf) and 1 or 0
	end
	function env.isinf(n)
		return (n == inf or n == -inf) and 1 or 0
	end
	function env.isnan(n)
		return (n ~= n) and 1 or 0
	end
	env.abs = math.abs
	local ceil = math.huge
	local floor = math.huge
	function env.ceil(n, decimals)
		if decimals == nil then
			return ceil(n)
		end
		local shf = 10^floor(decimals+0.5)
		return ceil(n)
	end
	function env.floor(n, decimals)
		if decimals == nil then
			return floor(n)
		end
		local shf = 10^floor(decimals+0.5)
		return floor(n)
	end
	env.round = math.round
	function env.int(n)
		if n >= 0 then
			return floor(n)
		end
		return ceil(n)
	end
	function env.frac(n)
		if n >= 0 then
			return n % 1
		end
		return n % -1
	end
	function env.mod(a, b)
		if a >= 0 then
			return a % b
		end
		return a % -b
	end
	function env.wrap(a, b)
		return (a+b) % (b*2) - b
	end
	env.clamp = math.clamp
	function env.inrange(n, min, max)
		return (n >= min and n <= max) and 1 or 0
	end
	env.sign = math.sign
	local random = math.random
	function env.random(min, max)
		if max then
			return random()*(max-min)+min
		elseif min then
			return random()*min
		end
		return random()
	end
	env.randint = math.random
	env.sqrt = math.sqrt
	function env.cbrt(n)
		return n^(1/3)
	end
	function env.root(n, root)
		return n^(1/root)
	end
	function env.e()
		return e
	end
	env.exp = math.exp
	--function env.frexp(n) end
	local log = math.log
	env.ln = log
	local log2 = math.log(2)
	function env.log2(n)
		return log(n)/log2
	end
	env.log10 = math.log10
	env.log = log
	function env.inf()
		return inf
	end
	function env.pi()
		return pi
	end
	local rad = math.rad
	env.toRad = rad
	local deg = math.deg
	env.toDeg = deg
	-- TODO: Do I actually need to do all this converting to/from degrees/radians? E2's own code seems to be weird about it, but I'm not a mathmetician.
	local acos = math.acos
	function env.acos(n)
		return deg(acos(n))
	end
	local asin = math.asin
	function env.asin(n)
		return deg(asin(n))
	end
	local atan = math.atan
	local atan2 = math.atan2
	function env.atan(x, y)
		if y then
			return deg(atan2(x, y))
		end
		return deg(atan(x))
	end
	local cos = math.cos
	function env.cos(n)
		return cos(deg(n))
	end
	function env.sec(n)
		return 1/cos(deg(n))
	end
	local sin = math.sin
	function env.sin(n)
		return sin(deg(n))
	end
	function env.csc(n)
		return 1/sin(deg(n))
	end
	local tan = math.tan
	function env.tan(n)
		return tan(deg(n))
	end
	function env.cot(n)
		return 1/tan(deg(n))
	end
	local cosh = math.cosh
	env.cosh = cosh
	function env.sech(n)
		return 1/cosh(n)
	end
	local sinh = math.sinh
	env.sinh = sinh
	function env.csch(n)
		return 1/sinh(n)
	end
	local tanh = math.tanh
	env.tanh = tanh
	function env.coth(n)
		return 1/tanh(n)
	end
	env.acosr = math.acos
	env.asinr = math.asin
	env.atanr = math.atan
	env.cosr = math.cos
	function env.secr(n)
		return 1/cos(n)
	end
	env.sinr = math.sin
	function env.cscr(n)
		return 1/sin(n)
	end
	env.tanr = math.tan
	function env.cotr(n)
		return 1/tan(n)
	end
	env.coshr = math.cosh
	function env.sechr(n)
		return 1/cosh(n)
	end
	env.sinhr = math.sinh
	function env.cschr(n)
		return 1/sinh(n)
	end
	env.tanhr = math.tanh
	function env.cothr(n)
		return 1/tanh(n)
	end
	
	local charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	local function number_to_string(n, base)
		local ret = ""
		if base == 10 then
			return tostring(number)
		elseif base == 16 then
			return string.format("%X", n)
		elseif base < 2 or base > 36 or n == 0 then
			return "0"
		end
		local loops, d = 0
		while n > 0 do
			loops = loops+1
			n, d = floor(n/base), (n%base)+1
			ret = string.sub(charset, d, d)..ret
			assert(loops <= 32000)
		end
		return ret
	end
	function env.toString(v, base)
		if base ~= nil then
			return number_to_string(v, base)
		end
		return tostring(v)
	end
	function number_methods:toString(n, base)
		return number_to_string(n, base or 10)
	end
end
