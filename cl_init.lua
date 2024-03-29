--@name Expression 2 emulator
--@includedata ./LICENSE

local print_prefix_color = Color(255, 63, 63)
local print_prefix = string.format("[%s] ", chip():entIndex())
local print_color = Color(152, 212, 255)
net.receive('hint', function(length)
	local text_len = net.readUInt(8)
	local text = net.readData(text_len)
	local duration = net.readDouble()
	pcall(notification.addLegacy, print_prefix..text, NOTIFY.GENERIC, duration)
end)
net.receive('print', function(length)
	local message_type = net.readUInt(8)
	local text_len = net.readUInt(8)
	local text = net.readData(text_len)
	pcall(printMessage, message_type, print_prefix..text)
end)
local name = "generic"
local name_prefix = string.format("%s ]\n[ ", chip():getChipName())
net.receive('name', function(length)
	local name_len = net.readUInt(8)
	name = net.readData(name_len)
	setName(name_prefix..name)
end)

--@include ./cl_egp3.lua
local egp = dofile('./cl_egp3.lua')
local screen = egp.new(chip():getLinkedComponents()[1])
hook.add('render', '', function()
	local ent = render.getScreenEntity()
	if ent == screen.entity then
		screen:draw()
	end
end)
