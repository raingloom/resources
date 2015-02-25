--cursor characters could be character #5 and #95

MatrixConsole={}
MatrixConsole.__index=MatrixConsole
CursorBlinkSpeed=1e3--in milliseconds
CursorCharacter="_"
ConsoleFont=dxCreateFont(":data/fonts/cour.ttf",12)
ConsoleTextColor=0xff00ff00

function MatrixConsole.new(width,height,locx,locy,str,padding)
	local ret,line
	ret = str and LinesToMatrix(str,width,padding) or {}
	padding=padding or ' '
	for y=#ret+1,height do
		line={}
		ret[y]=line
		for i=1,width do
			line[i]=padding
		end
	end
	ret.size={height,width}
	ret.cursorPosition={1,1}
	ret.location={locx or 0, locy or 0}
	ret.cursorString=CursorCharacter
	ret.cursorTimer=0
	ret.showCursor=true
	return setmetatable(ret,MatrixConsole)
end
MatrixConsole_new=MatrixConsole.new


function MatrixConsole:concat()
	local lines,concat={},table.concat
	for i=1,#self do
		lines[i]=concat(self[i])
	end
	return concat(lines,'\n')
end
MatrixConsole_concat=MatrixConsole.concat


function MatrixConsole:setCursor(y,x)
	self.cursorString=("\n"):rep(y-1)..(" "):rep(x-1)..CursorCharacter
	self.cursorPosition[1]=y
	self.cursorPosition[2]=x
end
MatrixConsole_setCursor=MatrixConsole.setCursor


function MatrixConsole:render(delta)
	local x,y=unpack(self.location)
	delta = delta or 100
	dxDrawText(self:concat(),x,y,nil,nil,ConsoleTextColor,nil,ConsoleFont)
	if self.showCursor then
		self.cursorTimer = self.cursorTimer + delta
		if self.cursorTimer >= CursorBlinkSpeed then
			self.cursorTimer = 0
			self.showCursor = not self.showCursor
		end
	end
	if self.showCursor then
		dxDrawText(self.cursorString,x,y,nil,nil,ConsoleTextColor,nil,ConsoleFont)
	end
end
MatrixConsole_render=MatrixConsole.render


function MatrixConsole:write(str)
	local y,x=unpack(self.cursorPosition)
	local line
	for chunk in matchn(str,self.size[2]) do
		line=self[y]
		for c in chunk:gmatch"." do
			if c=='\n' then
				y=y+1
				x=1
				line=self[y]
			else
				line[x]=c
				x=x+1
			end
		end
		y=y+1
	end
end
MatrixConsole_write=MatrixConsole.write
