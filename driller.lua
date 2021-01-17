local arg1, arg2 = ...
local fuelSlot = 1

for i = 1, arg1 do
	if turtle.getFuelLevel() == 0 then
		turtle.select(fuelSlot)
		turtle.refuel(fuelSlot)
	end
	turtle.digDown()
	turtle.down()
	for slot = 3, 16 do
		if turtle.getItemCount(slot) > 0 then
			turtle.select(slot)
			turtle.drop()
		end
	end
	turtle.select(fuelSlot)
end
shell.run("tunnel", arg2)
