VEHICLE_INSIDE = nil
LOCAL_CACHED_EVIDENCE = {}

_ammoNames = {
	AMMO_STUNGUN = 'Stungun Ammo',
	AMMO_PISTOL = 'Pistol Ammo',
	AMMO_SMG = 'SMG Ammo',
	AMMO_RIFLE = 'Rifle Ammo',
	AMMO_SHOTGUN = 'Shotgun Ammo',
	AMMO_SNIPER = 'Sniper Ammo',
	AMMO_FLARE = 'Flare Ammo',
	AMMO_MG = 'Machine Gun Ammo',
}

AddEventHandler('Evidence:Shared:DependencyUpdate', RetrieveComponents)
function RetrieveComponents()
	Logger = exports['mythic-base']:FetchComponent('Logger')
	Fetch = exports['mythic-base']:FetchComponent('Fetch')
	Callbacks = exports['mythic-base']:FetchComponent('Callbacks')
	Game = exports['mythic-base']:FetchComponent('Game')
	Targeting = exports['mythic-base']:FetchComponent('Targeting')
	Utils = exports['mythic-base']:FetchComponent('Utils')
	Keybinds = exports['mythic-base']:FetchComponent('Keybinds')
	Animations = exports['mythic-base']:FetchComponent('Animations')
	Notification = exports['mythic-base']:FetchComponent('Notification')
	Polyzone = exports['mythic-base']:FetchComponent('Polyzone')
	Jobs = exports['mythic-base']:FetchComponent('Jobs')
	Weapons = exports['mythic-base']:FetchComponent('Weapons')
	Progress = exports['mythic-base']:FetchComponent('Progress')
	Vehicles = exports['mythic-base']:FetchComponent('Vehicles')
	Targeting = exports['mythic-base']:FetchComponent('Targeting')
	ListMenu = exports['mythic-base']:FetchComponent('ListMenu')
	Action = exports['mythic-base']:FetchComponent('Action')
	Sounds = exports['mythic-base']:FetchComponent('Sounds')
	Inventory = exports['mythic-base']:FetchComponent('Inventory')
end

AddEventHandler('Core:Shared:Ready', function()
	exports['mythic-base']:RequestDependencies('Evidence', {
		'Logger',
		'Fetch',
		'Callbacks',
		'Game',
		'Menu',
		'Targeting',
		'Notification',
		'Utils',
		'Animations',
		'Keybinds',
		'Polyzone',
		'Jobs',
		'Weapons',
		'Progress',
		'Vehicles',
		'Targeting',
		'ListMenu',
		'Action',
		'Sounds',
		'Inventory',
	}, function(error)
		if #error > 0 then
			return
		end
		RetrieveComponents()

        Polyzone.Create:Box('evidence_ballistics_mrpd', vector3(470.7200, -1000.1774, 34.2400), 1.6, 2.2, {
            heading = 0,
            --debugPoly=true,
            minZ = 33.69,
            maxZ = 35.89
        }, {
            ballistics = true,
        })

        Polyzone.Create:Box('evidence_dna_mrpd', vector3(467.7934, -1002.7421, 34.2400), 1.0, 1.2, {
            heading = 0,
            minZ = 33.69,
            --debugPoly=true,
            maxZ = 35.89
        }, {
            dna = true,
        })

		Polyzone.Create:Box('evidence_ballistics_dpd', vector3(369.46, -1590.37, 25.45), 1.2, 1.6, {
			heading = 359,
			minZ = 24.45,
			maxZ = 27.25,
		}, {
			ballistics = true,
		})

		Polyzone.Create:Box('evidence_dna_dpd', vector3(367.9, -1592.18, 25.45), 1.2, 1.6, {
			heading = 0,
			minZ = 24.45,
			maxZ = 27.25,
		}, {
			dna = true,
		})

		Polyzone.Create:Box('evidence_ballistics_lmpd', vector3(849.52, -1311.05, 28.24), 1.8, 2, {
			heading = 0,
			--debugPoly=true,
			minZ = 27.24,
			maxZ = 29.84,
		}, {
			ballistics = true,
		})

		Polyzone.Create:Box('evidence_dna_guardius', vector3(-1066.9, -240.11, 49.85), 2.0, 1.6, {
			heading = 295,
			--debugPoly=true,
			minZ = 48.85,
			maxZ = 51.45,
		}, {
			dna = true,
		})

		Polyzone.Create:Box('evidence_ballistics_guardius', vector3(-1062.82, -237.75, 49.85), 2.0, 1.6, {
			heading = 295,
			--debugPoly=true,
			minZ = 48.85,
			maxZ = 51.45,
		}, {
			ballistics = true,
		})

		Polyzone.Create:Box('evidence_dna_lmpd', vector3(853.45, -1292.58, 28.24), 1.8, 1, {
			heading = 0,
			--debugPoly=true,
			minZ = 27.24,
			maxZ = 29.64,
		}, {
			dna = true,
		})

		Polyzone.Create:Box('evidence_dna_mt_zona_1', vector3(-444.11, -296.49, 34.91), 3.6, 1.6, {
			heading = 290,
			--debugPoly=true,
			minZ = 33.91,
			maxZ = 36.11,
		}, {
			dna = true,
		})

		Polyzone.Create:Box('evidence_dna_mt_zona_2', vector3(-442.69, -299.56, 34.91), 3.6, 1.6, {
			heading = 290,
			--debugPoly=true,
			minZ = 33.91,
			maxZ = 36.11,
		}, {
			dna = true,
		})

		Polyzone.Create:Box('evidence_dna_pb_hospital_1', vector3(312.110, -563.146, 42.284), 1.0, 2.0, {
			heading = 251.908,
			--debugPoly=true,
			minZ = 41.284,
			maxZ = 44.284,
		}, {
			dna = true,
		})

		Polyzone.Create:Box('evidence_dna_pb_hospital_2', vector3(309.074, -561.628, 42.284), 1.0, 2.0, {
			heading = 68.067,
			--debugPoly=true,
			minZ = 41.284,
			maxZ = 44.284,
		}, {
			dna = true,
		})


		Callbacks:RegisterClientCallback('Evidence:RunBallistics', function(data, cb)
			local success, alreadyFiled, matchingEvidence, policeWeaponId, serial = table.unpack(data)

			Animations.Emotes:Play('type3', false, 8000, true, true)
			Progress:Progress({
				name = 'gun_ballistics_test',
				duration = 8000,
				label = 'Testing Gun Ballistics',
				useWhileDead = false,
				canCancel = false,
				ignoreModifier = true,
				disarm = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
			}, function(status)
				if not status then
					if success then
						if alreadyFiled then
							Notification:Success('Ballistics Filed Successfully - Gun Was Already Filed')
						else
							Notification:Success('Ballistics Filed Successfully - Gun Now Filed')
						end

						local items = {}

						if serial  ~= nil then
							table.insert(items, {
								label = 'Weapon Serial Number',
								description = string.format('Serial: %s', serial or '<scratched off>'),
							})
						elseif policeWeaponId ~= nil then
							table.insert(items, {
								label = 'Police Weapon Identifier',
								description = string.format('Since the weapon had no serial number, a police identifier was given.<br>Identifier: %s', policeWeaponId),
							})
						else
							table.insert(items, {
								label = 'Unable To Locate Identifier',
								description = 'Weapon didnt come back to any identifier',
							})
						end

						if matchingEvidence and #matchingEvidence > 0 then
							Sounds.Play:Distance(4, 'demo.ogg', 0.4)
							table.insert(items, {
								label = 'Ballistics Matches Found',
								description = string.format('%s Projectile Matches Found When Compared to Filed Weapons', #matchingEvidence),
							})
							for k, v in ipairs(matchingEvidence) do
								table.insert(items, {
									label = string.format('Evidence %s', v),
								})
							end
						else
							table.insert(items, {
								label = 'No Ballistics Matches Found',
							})
						end

						ListMenu:Show({
							main = {
								label = 'Ballistics Comparison - Results',
								items = items,
							},
						})

					else
						Notification:Error('Ballistics Testing Failed')
					end
				end
			end)
		end)
	end)
end)

AddEventHandler('Vehicles:Client:EnterVehicle', function(veh)
	VEHICLE_INSIDE = veh
end)

AddEventHandler('Vehicles:Client:ExitVehicle', function()
	VEHICLE_INSIDE = nil
end)

local pendingEvidenceUpdate = false

function UpdateCachedEvidence()
	if not pendingEvidenceUpdate then
		pendingEvidenceUpdate = true
		SetTimeout(5000, function()
			pendingEvidenceUpdate = false
			SendCachedEvidence()
		end)
	end
end

function SendCachedEvidence()
	TriggerServerEvent('Evidence:Server:RecieveEvidence', LOCAL_CACHED_EVIDENCE)
	LOCAL_CACHED_EVIDENCE = {}
end