--Sends login ACK
addEventHandler("onPlayerLogin",root,function()
	triggerClientEvent("onLoginACK",source,source)
end)
