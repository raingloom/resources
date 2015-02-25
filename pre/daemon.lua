addEventHandler("onResourcePreStart",root,
function(res)
	local resname=getResourceName(res)
	local file
	if getResourceInfo(res,"process")=="1" then
		local xml=XML.load(":"..resname.."/meta.xml")
		local children=xml.children
		for i,node in ipairs(children) do
			if node:getAttribute"process"=='1' then
				file=FileOpen(string.format(":%s/%s",resname,node:getAttribute"src"))
				if file then
					
				end
			end
		end
	end
end)