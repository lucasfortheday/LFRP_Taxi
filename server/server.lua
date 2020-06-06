PerformHttpRequest("https://raw.githubusercontent.com/lucasfortheday/LFRP_Taxi/master/__resource.lua", function(errorCode, result, headers)
    local version = GetResourceMetadata(GetCurrentResourceName(), 'resource_version', 0)

    if string.find(tostring(result), version) == nil then
        print("\n\r[LFRP Taxi] The version on this server is not up to date. Please update now.\n\r")
    end
end, "GET", "", "")

RegisterServerEvent('LFRP_Taxi:payCab')
AddEventHandler('LFRP_Taxi:payCab', function(meters)
	local src = source
	
	local totalPrice = meters / 40.0
	local price = math.floor(totalPrice)
	
	if optional.use_essentialmode then
		TriggerEvent('es:getPlayerFromId', src, function(user)
			if user.getMoney() >= tonumber(price) then
				user.removeMoney(tonumber(price))
				TriggerClientEvent('LFRP_Taxi:payment-status', src, true)
			else
				TriggerClientEvent('LFRP_taxi:payment-status', src, false)
			end
		end)