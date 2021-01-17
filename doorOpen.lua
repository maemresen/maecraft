os.loadAPI("ocs/apis/sensor")

local proximity = sensor.wrap("top")

local acceptedPlayer = {}
acceptedPlayer["lxpenguin"] = true

local monitor = peripheral.wrap("monitor_5")

while true do
	sleep(0.2)
	local doorOpen = false
	for name, value in pairs(proximity.getTargets()) do
		if value["IsPlayer"] and value["Username"] then
			local username = value["Username"]
			local pos = value["Position"]
			local x = pos["X"]
			local y = pos["Y"]
			local z = pos["Z"]
			local inRange = (y == -1) and (-3 < x and x < 0) and (-4.5 < z and z < 1)
			--print("x=",x, ", y=", y, ", z=", z)
			doorOpen = inRange
		end
	end

	monitor.clear("=)")
	monitor.setCursorPos(1, 1)
	if doorOpen then
		--print("Welcome Home Reyiss")
		monitor.write("=)")
	else
		monitor.write("X")
	end
	redstone.setOutput("back", doorOpen)
end
