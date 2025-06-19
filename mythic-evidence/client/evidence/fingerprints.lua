-- fingerprints.lua
local activeFingerprints = {}

function LeaveFingerprint(location, quality)
    if not LocalPlayer.state.Character then return end
    
    local coords = GetEntityCoords(LocalPlayer.state.ped)
    local fingerprintId = "FPR-" .. math.random(10000, 99999) .. "-" .. GetCloudTimeAsInt()
    
    table.insert(LOCAL_CACHED_EVIDENCE, {
        type = 'fingerprint',
        route = LocalPlayer.state.currentRoute,
        coords = coords,
        data = {
            location = location, -- no needed anymore, the idea in my head was better but fk it, keep it for now
            quality = quality,
            FingerPrint = LocalPlayer.state.Character:GetData("SID"),
            id = fingerprintId
        },
        active = true,
    })
    
    activeFingerprints[fingerprintId] = true
    UpdateCachedEvidence()
end

RegisterNetEvent("Evidence:Client:Fingerprint", function(tooDegraded, success, evidenceId)
	Animations.Emotes:Play("type3", false, 5500, true, true)
	Progress:Progress({
		name = "finger_test",
		duration = 50000,
		label = "Running Fingerprint Through Database",
		useWhileDead = false,
		canCancel = false,
		ignoreModifier = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(status)
		if not status then
			if tooDegraded then
                return Notification:Error("Sample too degraded for testing")
			end
			if success then
				Notification:Success("Fingerprint Match Found")

				ListMenu:Show({
					main = {
						label = "Results",
						items = {
							{
								label = "Sample Evidence Identifier",
								description = evidenceId,
							},
							{
								label = string.format("Sample Serial"),
								description = success
							},
						},
					},
				})
			else
                Notification:Error("No match found in database")
			end
		end
	end)
end)

RegisterNetEvent('Evidence:Client:tryLeaveFingerprint', function(location, type)
	local hasGloves = Inventory.Check.Player:HasItem('hand_gloves', 1)
	local chance = 0

	if hasGloves then
		if type == 1 then
			chance = math.random(1, 50)
		else -- type == 2
			chance = math.random(30, 50)
		end
	else
		if type == 1 then
			chance = math.random(51, 100)
		else -- type == 2
			chance = math.random(75, 100)
		end
	end

	LeaveFingerprint(location, chance)
end)

RegisterNetEvent('Evidence:Client:trytakeFingerprint', function(entity, data)
Progress:Progress({
		name = "fingerprint_action",
		duration = 6000,
		label = "Performing Fingerprint sample",
		useWhileDead = false,
		canCancel = true,
		ignoreModifier = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			task = "WORLD_HUMAN_STAND_MOBILE",
		},
	}, function(cancelled)
		if not cancelled then
			Callbacks:ServerCallback("Evidence:Server:trytakeFingerprint", entity.serverId, function() end)
		end
	end)
end)

AddEventHandler('Characters:Client:Logout', function()
    activeFingerprints = {}
end)



-- Add this to `mythic-targeting\client\config.lua` inside `Config.PlayerMenu` table
	-- make sure to remove the comment thing (--) 
	-- see the image to more info https://prnt.sc/QGLQEsUfBhdK

	-- {
	-- 	icon = "fingerprint",
	-- 	text = "Take Fingerprint sample",
	-- 	event = "Evidence:Client:trytakeFingerprint",
	-- 	data = {},
	-- 	minDist = 3.0,
	-- 	jobPerms = {
	-- 		{
	-- 			job = "police",
	-- 			reqDuty = true,
	-- 		},
	-- 		{
	-- 			job = "prison",
	-- 			reqDuty = true,
	-- 		},
	-- 		{
	-- 			job = "ems",
	-- 			reqDuty = true,
	-- 		},
	-- 	},
	-- },
