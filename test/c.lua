time=0
byte=0
char=""
width,height=guiGetScreenSize()
x,y=width/2,height/2
--font=dxCreateFont(":loginpanel/cour.ttf",32)

function f (k)
	outputDebugString(k)
	byte = k=="arrow_u" and byte+1 or byte-1
	outputDebugString(byte)
	char = string.char(byte)
	str=("#%d#%s#"):format(byte,char)
end
bindKey("arrow_u","down",f)
bindKey("arrow_d","down",f)


addEventHandler("onClientPreRender",root,function()
	dxDrawText(str,x,y,nil,nil,nil,nil,font)
end)