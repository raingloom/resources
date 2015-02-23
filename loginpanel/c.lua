ConsoleMatrix={}
ConsoleSize={24,80}
WelcomeText=[[
Welcome to Rain's test server!
Enjoy your stay!

Rules:
1.A L L   H A I L  T H E   G L O W C L O U D  ! ! !
2.Be cool.
3.Don't be an asshole.
4.Have fun!]]
SPACE=" "
WelcomeTextMatrix=LinesToMatrix(WelcomeText,ConsoleSize[2],SPACE)
if #WelcomeTextMatrix<ConsoleSize[1] then
	local line={}
	for i=1,ConsoleSize[2] do line[i]=SPACE end
	for i=#WelcomeTextMatrix+1,ConsoleSize[1] do
		WelcomeTextMatrix[i]=line
	end
end

local line
for y=1,ConsoleSize[1] do
	line={}
	ConsoleMatrix[y]=line
	for x=1,ConsoleSize[2] do
		line[x]=' '
	end
end


--TODO: Make an optimized OOP structure to cache concatenated console lines
function ConsoleMatrix:concat()
	local lines,concat={},table.concat
	for i=1,ConsoleSize[1] do
		lines[i]=concat(self[i])
	end
	return concat(lines,'\n')
end


Processes={
    function(endsig)
		local yield,rand=coroutine.yield,math.random
		yield()
        for y=1,ConsoleSize[1] do
			for x=1,ConsoleSize[2] do
				ConsoleMatrix[y][x]=rand(0,9)
				yield()
			end
		end
		return endsig
    end,
    function(endsig)
		local yield=coroutine.yield
		yield()
        for y=1,ConsoleSize[1] do
			for x=1,ConsoleSize[2] do
				ConsoleMatrix[y][x]=WelcomeTextMatrix[y][x]
				yield()
			end
		end
		return endsig
    end,
}
Runs={12,10}
SIG=true
for k,v in ipairs(Processes) do Processes[k]=coroutine.wrap(v) end
for i=1,#Processes do Processes[i](SIG) end


function Run(plist,rlist)
    local p
	local i=1
    while i<=#plist do
        p=plist[i]
        for j=1,rlist[i] do
            if p()==SIG then
                table.remove(plist,i)
                table.remove(rlist,i)
				i=i-1
                break
            end
        end
		i=i+1
    end
end


----------------------
--EFFECTS START HERE--
----------------------
setPlayerHudComponentVisible ("all",false)
showChat(false)

local width, height = guiGetScreenSize()
local font=dxCreateFont("cour.ttf",16)
function RenderLoginEffects()
	dxDrawRectangle(0,0,width,height,0xff000000)
	if #Processes>0 then Run(Processes,Runs) end
	dxDrawText(ConsoleMatrix:concat(),0,0,nil,nil,0xff00ff00,nil,font)
end


--deactivate&cleanup
function onLoginACK()
	removeEventHandler("onClientRender",root,RenderLoginEffects)
	setPlayerHudComponentVisible ("all",true)
	showChat(true)
	removeEventHandler("onLoginACK",root,onLoginACK)
	removeEvent("onLoginACK")
end


addEventHandler("onClientRender",root,RenderLoginEffects)
addEvent("onLoginACK",true)
addEventHandler("onLoginACK",root,onLoginACK)