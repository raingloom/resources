setCameraClip(false,false)
local right,forward,up=Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1)
local width,height=guiGetScreenSize()
local origX,origY=Vector2(width/2,height/2)
local Rot=0
local Sensitivity=1
local cx0,cy0=0,0
local cx1,cy1=0,0
showCursor(true)
guiSetInputEnabled(false)
guiSetInputMode"allow_binds"
---[[
addEventHandler("onClientPreRender",root,function(deltaTime)
	deltaTime=deltaTime or 50
	local v6=Vector3(getPedBonePosition(localPlayer,6))
	local v7=Vector3(getPedBonePosition(localPlayer,7))
	local v8=Vector3(getPedBonePosition(localPlayer,8))
	local v67=(v6+v7)/2
	vr=v7-v6
	vu=v67-v8
	vf=vu:cross(vr)
	cx0,cy0=cx1,cy1
	cx1,cy1=getCursorPosition()
	dxDrawText(string.format("%f:%f <-> %f:%f",cx0,cy0,cx1,cy1),0,0)
	Rot=Rot-(cx1-cx0)*Sensitivity*deltaTime
	vf=rotateVectorAround(vf,"z",Rot)
	setCameraMatrix(v67,v67+vf)
end)--]]
--[[
addEventHandler("onClientRender",root,function()
	setCursorPosition(origX,origY)
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

function rotateVectorAround(vec,around,theta)
	local cosTheta=math.cos(theta)
	local sinTheta=math.sin(theta)
	local x,y,z=vec.x,vec.y,vec.z
	if type(around)=="string" then
		if around=="z" then
			return Vector3(
				x*cosTheta-y*sinTheta,
				x*sinTheta+y*cosTheta,
				vf.z)
		elseif around=="y" then
			return Vector3(
				x*cosTheta+z*sinTheta,
				y,
				-x*sinTheta+z*cosTheta)
		elseif around=="x" then
			return Vector3(
				x,
				y*cosTheta-z*sinTheta,
				y*sinTheta+z*cosTheta)
		else
			error"invalid rotation axis"
		end
	else--general vector case
		error"Not implemented"
	end
end

addEventHandler("onResourceStop",resourceRoot,function()
	setCameraTarget(localPlayer)
	setCameraClip(true,true)
end)