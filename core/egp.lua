return function(instance, env)
	env._TEXFILTER_NONE = TEXFILTER.NONE
	env._TEXFILTER_POINT = TEXFILTER.POINT
	env._TEXFILTER_LINEAR = TEXFILTER.LINEAR
	env._TEXFILTER_ANISOTROPIC = TEXFILTER.ANISOTROPIC
	
	return function()
		local wirelink_meta = instance.types.wirelink
		local wirelink_methods = wirelink_meta.__index
		local getwl = wirelink_meta.getwl
		local NULL = wirelink_meta.NULL
		
		--function env.egpMaxObjects() end
		--function env.egpMaxUmsgPerSecond() end
		--function env.egpBytesLeft() end
		--function env.egpCanSendUmsg() end
		--function env.egpClearQueue() end
		--function env.egpQueue() end
		--function env.egpQueueClk(screen) end
		--function env.egpQueueScreen() end
		--function env.egpQueueScreenWirelink() end
		--function env.egpQueuePlayer() end
		--function env.egpQueueClkPly(ply) end
		
		--function wirelink_methods:egpSaveFrame(index) end
		--function wirelink_methods:egpLoadFrame(index) end
		--function wirelink_methods:egpOrder(index, order) end
		--function wirelink_methods:egpOrderAbove(index, above) end
		--function wirelink_methods:egpOrderBelow(index, below) end
		--function wirelink_methods:egpBox(index, pos, size) end
		--function wirelink_methods:egpBoxOutline(index, pos, size) end
		--function wirelink_methods:egpRoundedBox(index, pos, size) end
		--function wirelink_methods:egpRadius(index, radius) end
		--function wirelink_methods:egpRoundedBoxOutline(index, pos, size) end
		--function wirelink_methods:egpText(index, text, pos) end
		--function wirelink_methods:egpTextLayout(index, text, pos, size) end
		--function wirelink_methods:egpSetText(index, text) end
		--function wirelink_methods:egpAlign(index, halign, valign) end
		--function wirelink_methods:egpFiltering(index, filtering) end
		--function wirelink_methods:egpGlobalFiltering(filtering) end
		--function wirelink_methods:egpFont(index, text, size) end
		--function wirelink_methods:egpPoly(index, args, ...) end
		--function wirelink_methods:egpPolyOutline(index, args, ...) end
		--function wirelink_methods:egpAddVertices(index, args) end
		--function wirelink_methods:egpLineStrip(index, args, ...) end
		--function wirelink_methods:egpLine(index, pos1, pos2) end
		--function wirelink_methods:egpCircle(index, pos1, size) end
		--function wirelink_methods:egpCircleOutline(index, pos1, size) end
		--function wirelink_methods:egpTriangle(index, v1, v2, v3) end
		--function wirelink_methods:egpTriangleOutline(index, v1, v2, v3) end
		--function wirelink_methods:egpWedge(index, pos, size) end
		--function wirelink_methods:egpWedgeOutline(index, pos, size) end
		--function wirelink_methods:egp3DTracker(index, pos, directionality) end
		--function wirelink_methods:egpPos(index, pos) end
		--function wirelink_methods:egpSize(index, size) end
		--function wirelink_methods:egpAngle(index, worldpos, axispos, angle) end
		--function wirelink_methods:egpColor(index, r, g, b, a) end
		--function wirelink_methods:egpAlpha(index, a) end
		--function wirelink_methods:egpMaterial(index, material) end
		--function wirelink_methods:egpMaterialFromScreen(index, gpu) end
		--function wirelink_methods:egpFidelity(index, fidelity) end
		--function wirelink_methods:egpParent(index, parent) end
		--function wirelink_methods:egpTrackerParent(index) end
		--function wirelink_methods:egpParentToCursor(index) end
		--function wirelink_methods:egpUnParent(index) end
		--function wirelink_methods:egpClear() end
		--function wirelink_methods:egpRemove(index) end
		--function wirelink_methods:egpPos(index) end
		--function wirelink_methods:egpGlobalPos(index) end
		--function wirelink_methods:egpGlobalVertices(index) end
		--function wirelink_methods:egpSizeNum(index) end
		--function wirelink_methods:egpColor4(index) end
		--function wirelink_methods:egpVertices(index) end
		--function wirelink_methods:egpObjectIndexes() end
		--function wirelink_methods:egpObjectTypes() end
		--function wirelink_methods:egpObjectType(index) end
		--function wirelink_methods:egpCopy(index, fromindex) end
		--function wirelink_methods:egpCursor(ply) end
		--function wirelink_methods:egpScrSize(ply) end
		--function wirelink_methods:egpScrW(ply) end
		--function wirelink_methods:egpScrH(ply) end
		--function wirelink_methods:egpHasObject(index) end
		--function wirelink_methods:egpObjectContainsPoint(index, point) end
		--function wirelink_methods:egpScale(xScale, yScale) end
		--function wirelink_methods:egpResolution(topleft, bottomright) end
		--function wirelink_methods:egpOrigin() end
		--function wirelink_methods:egpDrawTopLeft(onoff) end
		--function wirelink_methods:egpToWorld(pos) end
		--function wirelink_methods:egpHudToggle() end
		--function wirelink_methods:egpNumObjects() end
		--function wirelink_methods:egpClearQueue() end
		--function wirelink_methods:egpRunOnQueue(yesno) end
	end
end
