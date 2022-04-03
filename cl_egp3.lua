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
local tbl = {
	{
		--ID = EGP.Objects.Names["Box"],
		Settings = {
			x = 256,
			y = 256,
			h = 356,
			w = 356,
			material = mat("expression 2/cog"),
			r = 150,
			g = 34,
			b = 34,
			a = 255
		}
	},
	{
		--ID = EGP.Objects.Names["Text"],
		Settings = {
			x = 256,
			y = 256,
			text = "EGP 3",
			font = "WireGPU_ConsoleFont",
			valign = 1,
			halign = 1,
			size = 50,
			r = 135,
			g = 135,
			b = 135,
			a = 255
		}
	},
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
		local t1s = tbl[1].Settings
		render.setMaterial(t1s.material)
		render.setRGBA(t1s.r, t1s.g, t1s.b, t1s.a)
		render.drawTexturedRect(t1s.x-t1s.w/2, t1s.y-t1s.h/2, t1s.w, t1s.h)
		local t2s = tbl[2].Settings
		render.setFont(WireEGP_50_WireGPU_ConsoleFont)
		render.setRGBA(t2s.r, t2s.g, t2s.b, t2s.a)
		render.drawSimpleText(t2s.x, t2s.y, t2s.text, t2s.halign, t2s.valign)
	render.popMatrix()
end)
