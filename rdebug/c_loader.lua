--[[--
	@return the server-side standard library's source code, which you can load with loadstring
	@usage assert(pcall(loadstring(exports.rdebug:getStdSource())))
]]
function s_getStdSource()
	local buf={}
	local insert=table.insert
	local f=assert(fileOpen("s_std.lua",true),"Could not find server-side standard library source")
	fileSetPos(f,0)
	while not fileIsEOF(f) do
		insert(buf,fileRead(f,500))
	end
	fileClose(f)
	return table.concat(buf)
end