---
-- Name: Door Open
-- Desc: Give the redstone
--
os.loadAPI("ocs/apis/sensor")

--
-- Constants
--
local PROXIMITY_SENSOR_DIR = "top"
local MONITOR_ID = "monitor_5"
ACCEPTED_PLAYERS = {}
ACCEPTED_PLAYERS["lxpenguin"] = true

--
-- Peripheral Devices
--
proximity = sensor.wrap(PROXIMITY_SENSOR_DIR)
monitor = peripheral.wrap(MONITOR_ID)

--
-- Global States
--
STATE_DOOR_OPEN = false

--
-- Functions
--
function findAcceptedPlayers()
	for name, value in pairs(proximity.getTargets()) do
		if value["IsPlayer"] then
			--
			-- Check only players
			--
			local username = value["Username"]
			local pos = value["Position"]
			local x = pos["X"]
			local y = pos["Y"]
			local z = pos["Z"]
			local inRange = (y == -1) and (-3 < x and x < 0) and (-4.5 < z and z < 0)
			--print("x=",x, ", y=", y, ", z=", z)
			if inRange then
				if not STATE_DOOR_OPEN then
					monitor.clear()
					monitor.setCursorPos(1, 1)
					monitor.write("Scan")
					monitor.setCursorPos(1, 2)
					monitor.write("Face...")
					monitor.setCursorPos(1, 3)
					monitor.write("Hold")
					monitor.setCursorPos(1, 4)
					monitor.write("On :)")
					sleep(0.5)
				end
				if ACCEPTED_PLAYERS[username] then
					return true
				end
			end
		end
	end
	return false
end

function loop()
	while true do
		--
		-- Search if one of accepted player is in range of sensor
		--
		STATE_DOOR_OPEN = findAcceptedPlayers() or false
		redstone.setOutput("back", STATE_DOOR_OPEN)

		monitor.clear()
		if STATE_DOOR_OPEN then
			monitor.setCursorPos(1, 1)
			monitor.write("Reis")
			monitor.setCursorPos(1, 2)
			monitor.write("Eve")
			monitor.setCursorPos(1, 3)
			monitor.write("Hos")
			monitor.setCursorPos(1, 4)
			monitor.write("Geldin")
		else
			for i = 1, 3 do
				local a = i
				local b = 6 - i
				monitor.setCursorPos(a + 1, a)
				monitor.write("X")
				monitor.setCursorPos(a + 1, b)
				monitor.write("X")
				monitor.setCursorPos(b + 1, a)
				monitor.write("X")
				monitor.setCursorPos(b + 1, b)
				monitor.write("X")
			end
		end

		sleep(0.2)
	end
end

loop()
