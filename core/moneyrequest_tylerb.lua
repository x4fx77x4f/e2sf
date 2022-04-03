-- Derived from https://github.com/TylerB260/moneyRequest-v1
return function(instance, env, post)
	instance.maxreq = false
	instance.allowgive = true
	return function()
		local entity_meta = instance.types.entity
		local entity_methods = entity_meta.__index
		local getent = entity_meta.getent
		local NULL = entity_meta.NULL
		
		local function checkfinite(n)
			return n == n and n ~= math.huge and n ~= -math.huge
		end
		
		local clk_money = instance:new_clk('moneyClk', true)
		function env.moneyClk(str)
			if str and str ~= clk_money.title then
				return 0
			end
			return clk_money._running and 1 or 0
		end
		function env.moneyClkTitle()
			return clk_money._running and clk_money.title or ""
		end
		function env.moneyClkAmount()
			return clk_money._running and clk_money.amount or 0
		end
		function env.moneyClkPlayer()
			return instance:wrap(clk_money._running and clk_money.player:isPlayer() and clk_money.player or NULL, entity_meta)
		end
		
		local clk_moneyNo = instance:new_clk('moneyNoClk', true)
		function env.moneyNoClk(str)
			if str and str ~= clk_moneyNo.title then
				return 0
			end
			return clk_moneyNo._running and 1 or 0
		end
		function env.moneyNoClkTitle()
			return clk_moneyNo._running and clk_moneyNo.title or ""
		end
		function env.moneyNoClkAmount()
			return clk_moneyNo._running and clk_moneyNo.amount or 0
		end
		function env.moneyNoClkPlayer()
			return instance:wrap(clk_moneyNo._running and clk_moneyNo.player:isPlayer() and clk_moneyNo.player or NULL, entity_meta)
		end
		
		local clk_moneyTimeout = instance:new_clk('moneyTimeout', true)
		function env.moneyTimeout(str)
			if str and str ~= moneyTimeout.title then
				return 0
			end
			return clk_moneyTimeout._running and 1 or 0
		end
		function env.moneyTimeoutTitle()
			return clk_moneyTimeout._running and clk_moneyTimeout.title or ""
		end
		function env.moneyTimeoutAmount()
			return clk_moneyTimeout._running and clk_moneyTimeout.amount or 0
		end
		function env.moneyTimeoutPlayer()
			return instance:wrap(clk_moneyTimeout._running and clk_moneyTimeout.player:isPlayer() and clk_moneyTimeout.player or NULL, entity_meta)
		end
		
		function env.moneyRequest(ply, amount, timeout, title)
			if type(timeout) == 'string' then
				timeout, title = title, timeout
			end
			local asker = instance.owner
			ply = getent(ply, true)
			if (
				not checkfinite(amount) or
				not isValid(ply) or
				not ply:isPlayer() or
				not isValid(asker) or
				not asker:isPlayer() or
				not amount or
				amount <= 0
			) then
				return 0
			end
			if instance.maxreq and instance.maxreq >= 1 and amount > math.floor(instance.maxreq) then
				instance:print_target(asker, string.format("The server has restricted the maximum amount of money you can transfer to $%s.", instance.maxreq))
				return 0
			end
			if ply:getMoney()-amount < 0 then
				instance:print_target(asker, "The player cannot afford that transaction.")
				return 0
			end
			if not darkrp.canMakeMoneyRequest(ply) then
				return 0
			end
			timeout = math.clamp(timeout or 0, 0, 30)
			title = string.sub(title or "Money Request", 1, 20)
			darkrp.requestMoney(ply, amount, title, function()
				if not instance or not instance.ready then
					return
				end
				instance:print_target(asker, string.format("You received $%s from %s.", amount, ply:getName()))
				instance:print_target(ply, string.format("You gave $%s to %s.", amount, ply:getName()))
				clk_money.player = ply
				clk_money.amount = amount
				clk_money.title = title
				instance:run_clk('money')
			end, function(err)
				if not instance or not instance.ready then
					return
				end
				if err == 'REQUEST_TIMEOUT' then
					moneyTimeout.player = ply
					moneyTimeout.amount = amount
					moneyTimeout.title = title
					instance:run_clk('moneyTimeout')
				else
					clk_moneyNo.player = ply
					clk_moneyNo.amount = amount
					clk_moneyNo.title = title
					instance:run_clk('moneyNo')
				end
			end)
		end
		function env.moneyGive(ply, amount)
			local giver = instance.owner
			if not checkfinite(amount) then
				return 0
			end
			if not instance.allowgive then
				instance:print_target(giver, "The server has disabled moneyGive().")
				return 0
			end
			if (
				not isValid(ply) or
				not ply:isPlayer() or
				not isValid(giver) or
				not giver:isPlayer() or
				not amount or
				amount < 1
			) then
				return 0
			end
			amount = math.floor(amount)
			if instance.maxreq and instance.maxreq >= 1 and amount > math.floor(instance.maxreq) then
				instance:print_target(asker, string.format("The server has restricted the maximum amount of money you can transfer to $%s.", instance.maxreq))
				return 0
			end
			local giver_money = giver:getMoney()
			if giver_money and giver_money-amount < 0 then
				instance:print_target(asker, string.format("Your E2 attempted to give $%s, which you can't afford.", amount))
				return 0
			end
			if not darkrp.canGiveMoney() then
				return 0
			end
			darkrp.payPlayer(giver, ply, amount)
			instance:print_target(ply, string.format("You received $%s from %s's E2.", amount, ply:getName()))
			instance:print_target(giver, string.format("You gave $%s to %s.", amount, ply:getName()))
		end
		
		function entity_methods:money()
			self = getent(self)
			if self:isPlayer() then
				return math.floor(self:getMoney() or 0)
			end
			return self:getClass() == 'spawned_money' and self:getAmount() or 0
		end
		entity_methods.moneyAmount = entity_methods.money
	end
end
