--@name EGP v3
--@client
local WireEGP_50_WireGPU_ConsoleFont = render.createFont(
	'WireGPU_ConsoleFont', -- not a valid font name i'm pretty sure, but it's what egp actually does so
	50, -- this is meant to specified in tbl, but cba to do it that way
	800,
	true,
	false
) -- https://github.com/wiremod/wire/blob/a031e4d/lua/entities/gmod_wire_egp/lib/objects/text.lua#L43
local mat = material.load
local EGP = {Objects={Names={}}}
local tbl = {
	-- [[
	{ID=EGP.Objects.Names['Box'], Settings={x=256, y=256, h=356, w=356, material=mat('expression 2/cog'), r=150, g=34, b=34, a=255}},
	{ID=EGP.Objects.Names['Text'], Settings={x=256, y=256, text="EGP 3", font='WireGPU_ConsoleFont', valign=1, halign=1, size=50, r=135, g=135, b=135, a=255}},
	--]]
	--[[
	{ID=EGP.Objects.Names['Box'], Settings={x=256, y=256, w=362, h=362, material=true, angle=135, r=75, g=75, b=200, a=255}},
	{ID=EGP.Objects.Names['Box'], Settings={x=256, y=256, w=340, h=340, material=true, angle=135, r=10, g=10, b=10, a=255}},
	{ID=EGP.Objects.Names['Text'], Settings={x=229, y=28, text="E", size=100, fontid=4, r=200, g=50, b=50, a=255}},
	{ID=EGP.Objects.Names['Text'], Settings={x=50, y=200, text="G", size=100, fontid=4, r=200, g=50, b=50, a=255}},
	{ID=EGP.Objects.Names['Text'], Settings={x=400, y=200, text="P", size=100, fontid=4, r=200, g=50, b=50, a=255}},
	{ID=EGP.Objects.Names['Text'], Settings={x=228, y=375, text="2", size=100, fontid=4, r=200, g=50, b=50, a=255}},
	{ID=EGP.Objects.Names['Box'], Settings={x=256, y=256, w=256, h=256, material=mat('expression 2/cog'), angle=45, r=255, g=50, b=50, a=255}},
	{ID=EGP.Objects.Names['Box'], Settings={x=128, y=241, w=256, h=30, material=true, r=10, g=10, b=10, a=255}},
	{ID=EGP.Objects.Names['Box'], Settings={x=241, y=128, w=30, h=256, material=true, r=10, g=10, b=10, a=255}},
	{ID=EGP.Objects.Names['Circle'], Settings={x=256, y=256, w=70, h=70, material=true, r=255, g=50, b=50, a=255}},
	{ID=EGP.Objects.Names['Box'], Settings={x=256, y=256, w=362, h=362, material=mat('gui/center_gradient'), angle=135, r=75, g=75, b=200, a=75}},
	{ID=EGP.Objects.Names['Box'], Settings={x=256, y=256, w=362, h=362, material=mat('gui/center_gradient'), angle=135, r=75, g=75, b=200, a=75}},
	--]]
} -- https://github.com/wiremod/wire/blob/a031e4d/lua/entities/gmod_wire_egp/lib/egplib/objectcontrol.lua#L248
local mtx = Matrix()
local scale = Vector(1, 1)
hook.add('render', '', function()
	local sw, sh = render.getResolution()
	scale[1] = sw/512
	scale[2] = sh/512
	mtx:setScale(scale)
	sw, sh = 512, 512
	render.pushMatrix(mtx)
		for k, v in ipairs(tbl) do
			v = v.Settings
			render.setRGBA(v.r, v.g, v.b, v.a)
			if v.material then
				if v.material == true then
					render.drawRect(v.x-v.w/2, v.y-v.h/2, v.w, v.h)
				else
					render.setMaterial(v.material)
					render.drawTexturedRect(v.x-v.w/2, v.y-v.h/2, v.w, v.h)
				end
			elseif v.text then
				render.setFont(WireEGP_50_WireGPU_ConsoleFont)
				render.drawSimpleText(v.x, v.y, v.text, v.halign, v.valign)
			end
		end
	render.popMatrix()
end)
