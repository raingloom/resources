function iprep(file,mode)
	local chunk = {n=0}
	for line in iterLinesInFile(file,mode) do
		 if string.find(line, "^#") then
			table.insert(chunk, string.sub(line, 2) .. "\n")
		 else
			local last = 1
			for text, expr, index in string.gmatch(line, "(.-)$(%b())()") do 
				last = index
				if text ~= "" then
					table.insert(chunk, string.format('coroutine.yield %q ', text))
				end
				table.insert(chunk, string.format('coroutine.yield%s ', expr))
			end
			table.insert(chunk, string.format('coroutine.yield %q\n',string.sub(line, last).."\n"))
		end
	end
	return coroutine.wrap(loadstring(table.concat(chunk)))
end
function preProcessFile(file,mode)
	local buf={}
	for chunk in iprep(file,mode) do
		table.insert(buf,chunk)
	end
	return table.concat(buf,chunk)
end
