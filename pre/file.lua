function iterLinesInFile (file,mode)
	if type(file)=="string" then
		file=fileOpen(file,mode)
	end
	local eof,endl=fileIsEOF(file),'\n'
	return function ()
		local buf,len,char={},0
		if eof then return nil else
			repeat
				char=fileRead(file,1)
				table.insert(buf,char)
				eof=fileIsEOF(file)
				len=len+1
			until eof or char==endl
		end
		return table.concat(buf,nil,nil,len-1)--trim trailing newline, as in the standard API
	end
end