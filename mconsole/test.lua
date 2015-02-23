local m = MatrixConsole.new ( 80, 24, 0, 0, [[
THIS IS NOT A TEST!!!!
Note: we lied.
This is actually a test.
]])
addEventHandler("onClientRender",root,function()m:render()end)
local function f(key)
	if key=="arrow_u" then
		m:setCursor((m.cursorPosition[1]-2)%m.size[1]+1,m.cursorPosition[2])
	elseif key=="arrow_d" then
		m:setCursor((m.cursorPosition[1])%m.size[1]+1,m.cursorPosition[2])
	elseif key=="arrow_l" then
		m:setCursor(m.cursorPosition[1],(m.cursorPosition[2]-2)%m.size[2]+1)
	elseif key=="arrow_r" then
		m:setCursor(m.cursorPosition[1],(m.cursorPosition[2])%m.size[2]+1)
	end
end

bindKey("arrow_u","down",f)
bindKey("arrow_d","down",f)
bindKey("arrow_l","down",f)
bindKey("arrow_r","down",f)