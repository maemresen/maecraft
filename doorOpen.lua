os.loadAPI("ocs/apis/sensor")

-- Periphal Devices
local proximity = sensor.wrap("top")
local monitor = peripheral.wrap("monitor_5")

-- Local Variables
local acceptedPlayer = {}
acceptedPlayer["lxpenguin"] = true
local doorOpen = false

while true do
	sleep(0.2)

	local playerFound = false
	for name, value in pairs(proximity.getTargets()) do
		if playerFound then
			break
		end
		if value["IsPlayer"] then
			local username = value["Username"]
			local pos = value["Position"]
			local x = pos["X"]
			local y = pos["Y"]
			local z = pos["Z"]
			local inRange = (y == -1) and (-3 < x and x < 0) and (-4.5 < z and z < 0)
			--print("x=",x, ", y=", y, ", z=", z)

			if inRange then
				if not doorOpen then
					monitor.clear()
					monitor.setCursorPos(1, 1)
					monitor.write("Scan")
					monitor.setCursorPos(1, 2)
					monitor.write("Face...")
					monitor.setCursorPos(1, 3)
					monitor.write("Hold")
					monitor.setCursorPos(1, 4)
					monitor.write("On :)")
					sleep(2)
				end
				playerFound = acceptedPlayer[username]
			end
		end
	end

	doorOpen = playerFound or false
	redstone.setOutput("back", doorOpen)

	monitor.clear()
	if doorOpen then
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
end
