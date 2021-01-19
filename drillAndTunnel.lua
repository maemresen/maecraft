local depth = ...

-- Constants
local SLOT_FUEL = 1
local SLOT_LADDER = 2
local SLOT_BLOCK = 3

-- Functions
function refuel()
	if turtle.getFuelLevel() == 0 then
		turtle.select(SLOT_FUEL)
		turtle.refuel(1)
	end
end

-- Putting Ladders
for i = 1, depth do
	refuel()
	turtle.digDown()
	turtle.down()

	-- put ladder
	turtle.dig()
	turtle.select(SLOT_LADDER)
	turtle.place()
end

-- Closing second drill
for i = 1, depth do
	refuel()
	turtle.up()
	turtle.select(SLOT_BLOCK)
	turtle.placeDown()
end
