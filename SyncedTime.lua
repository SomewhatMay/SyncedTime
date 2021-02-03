--====================================--
---/// Scripted By: UndefinedN00B \\\---
--====================================--
--[[

Licenced under MIT

Module Script
Insert in Replicated Storage
For more information on how to use the module, 
visit: https://github.com/UndefinedN00B/SyncedTime/

]]--

local m = {
	AverageCeckRate = 1;
}

local averageStarts = {}
local rus = game:GetService("RunService")
local comms
local start

function m:Init(uselocalAverage, localCheckRate, resetGlobalAverage)
	local initCallTick = tick()
	
	if rus:IsServer() then
		comms = Instance.new("RemoteFunction")
		comms.Name = "CSComms"
		comms.Parent = script
		
		start = Instance.new("NumberValue")
		start.Name = "ServerStart"
		start.Value = 0
		start.Parent = script
		
		comms.OnServerInvoke = function()
			return tick()
		end
		
	elseif rus:IsClient() then
		comms = script:WaitForChild("CSComms")
		start = script:WaitForChild("ServerStart")
		
		local timesToCheck = m.AverageCeckRate
		local averageToUse = averageStarts
		
		if uselocalAverage == true then
			averageToUse = {}
		end
		
		if typeof(localCheckRate) == "number" then
			timesToCheck = localCheckRate
		end
		
		for i=1, timesToCheck, 1 do
			local invokeTime = tick()
			local got = comms:InvokeServer()
			local dt = tick() - invokeTime
			local trip1 = dt/2
			
			table.insert(averageToUse, tick() - (got + trip1))
		end
		
		local average = 0
		
		for _, v in pairs(averageToUse) do
			average = average + v
		end
		
		average = average/#averageToUse
		
		start.Value = average
		
		if resetGlobalAverage == true then
			averageStarts = {}
		end
	end
	
	print(([[
//Synced Time\\
Init() called on Server: %s
Init() completed
Start.Value Difference: %s
Function Yeild Delay: %s
averageStarts Table:
	]]):format(tostring(rus:IsServer()), start.Value, tick() - initCallTick), averageStarts, "\n\n")
end

function m:GetTime()
	return tick() - start.Value
end

return m
