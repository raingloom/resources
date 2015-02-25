setCameraClip(false,false)
local right,forward,up=Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1)
local Rot=0
---[[
addEventHandler("onClientPreRender",root,function(deltaTime)
	local v6=Vector3(getPedBonePosition(localPlayer,6))
	local v7=Vector3(getPedBonePosition(localPlayer,7))
	local v8=Vector3(getPedBonePosition(localPlayer,8))
	local v67=(v6+v7)/2
	local rx,ry,rz=getElementRotation(localPlayer)
	setCameraMatrix(v67,v67+((v67-v8):cross(v7-v6)))
end)--]]

--[[
addEventHandler('onClientRender', root, function()
	for bone = 1, 54 do
	 local bonePos = {getPedBonePosition(localPlayer, bone)}
		if bonePos[1] then
		 local screen = {getScreenFromWorldPosition(unpack(bonePos))}
			if screen[1] then
			 dxDrawText(''..bone, screen[1], screen[2])
			end
		end
	end
end)--]]

addEventHandler("onResourceStop",resourceRoot,function()
	setCameraTarget(localPlayer)
	setCameraClip(true,true)
end)