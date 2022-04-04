local egp_meta = {}
local egp_methods = {}
egp_meta.__index = egp_methods
function egp_meta.new(ent)
	return setmetatable({
		entity = ent,
		fonts = {},
	}, egp_meta)
end

function egp_methods:set_font(font, size)
	local fonts = self.fonts
	local k = 'WireEGP_'..size..'_'..font
	local v = fonts[k]
	if not v then
		v = render.createFont(font, size, 800, true, false)
		fonts[k] = v
	end
	render.setFont(v)
end
egp_methods.home_screen = {
	--[[ custom
	{id='Box', x=256, y=256, w=362, h=362, material=material.load('radon/starfall2'), r=78, g=122, b=199, a=255},
	{id='Text', x=258, y=258, text="E2SF", font='Roboto', halign=1, valign=1, size=50, r=0, g=0, b=0, a=255},
	{id='Text', x=256, y=256, text="E2SF", font='Roboto', halign=1, valign=1, size=50, r=255, g=255, b=255, a=255},
	--]]
	-- https://github.com/wiremod/wire/blob/a031e4d/lua/entities/gmod_wire_egp/lib/egplib/objectcontrol.lua#L248
	-- [[ EGP v3
	{id='Box', x=256, y=256, h=356, w=356, material=material.load('expression 2/cog'), r=150, g=34, b=34, a=255},
	{id='Text', x=256, y=256, text="EGP 3", font='WireGPU_ConsoleFont', valign=1, halign=1, size=50, r=135, g=135, b=135, a=255},
	--]]
	--[[ "Old homescreen (EGP v2 home screen design contest winner)"
	{id='Box', x=256, y=256, w=362, h=362, material=true, angle=135, r=75, g=75, b=200, a=255},
	{id='Box', x=256, y=256, w=340, h=340, material=true, angle=135, r=10, g=10, b=10, a=255},
	{id='Text', x=229, y=28, text="E", size=100, fontid=4, r=200, g=50, b=50, a=255},
	{id='Text', x=50, y=200, text="G", size=100, fontid=4, r=200, g=50, b=50, a=255},
	{id='Text', x=400, y=200, text="P", size=100, fontid=4, r=200, g=50, b=50, a=255},
	{id='Text', x=228, y=375, text="2", size=100, fontid=4, r=200, g=50, b=50, a=255},
	{id='Box', x=256, y=256, w=256, h=256, material=material.load('expression 2/cog'), angle=45, r=255, g=50, b=50, a=255},
	{id='Box', x=128, y=241, w=256, h=30, material=true, r=10, g=10, b=10, a=255},
	{id='Box', x=241, y=128, w=30, h=256, material=true, r=10, g=10, b=10, a=255},
	{id='Circle', x=256, y=256, w=70, h=70, material=true, r=255, g=50, b=50, a=255},
	{id='Box', x=256, y=256, w=362, h=362, material=material.load('gui/center_gradient'), angle=135, r=75, g=75, b=200, a=75},
	{id='Box', x=256, y=256, w=362, h=362, material=material.load('gui/center_gradient'), angle=135, r=75, g=75, b=200, a=75},
	--]]
}
local mtx = Matrix()
local scale = Vector(1, 1)
function egp_methods:draw()
	local sw, sh = render.getResolution()
	scale[1] = sw/512
	scale[2] = sh/512
	mtx:setScale(scale)
	sw, sh = 512, 512
	render.pushMatrix(mtx)
		for k, v in ipairs(self.home_screen) do
			render.setRGBA(v.r, v.g, v.b, v.a)
			if v.id == 'Box' then
				if v.material == true then
					render.drawRect(v.x-v.w/2, v.y-v.h/2, v.w, v.h)
				else
					render.setMaterial(v.material)
					render.drawTexturedRect(v.x-v.w/2, v.y-v.h/2, v.w, v.h)
				end
			elseif v.id == 'Text' then
				self:set_font(v.font, v.size)
				render.drawSimpleText(v.x, v.y, v.text, v.halign, v.valign)
			end
		end
	render.popMatrix()
end

return egp_meta
