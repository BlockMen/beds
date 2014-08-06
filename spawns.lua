local file = minetest.get_worldpath() .. "/beds_spawns"
local writing = false

function beds.read_spawns()
	while writing do
		-- wait until spawns are safed
	end
	local spawns = beds.spawn
	local input = io.open(file, "r")
	if input then
		repeat
		local x = input:read("*n")
		if x == nil then
            		break
            	end
		local y = input:read("*n")
		local z = input:read("*n")
		local name = input:read("*l")
		spawns[name:sub(2)] = {x = x, y = y, z = z}
		until input:read(0) == nil
		io.close(input)
	else
		spawns = {}
	end
end

--beds.read_spawns()

function beds.save_spawns()
	writing = true
	local output = io.open(file, "w")
	for i, v in pairs(beds.spawn) do
		output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
	end
	io.close(output)
	writing = false
end

function beds.set_spawns()
	for name,_ in pairs(beds.player) do
		local player = minetest.get_player_by_name(name)
		local p = player:getpos()
		beds.spawn[name] = p
	end
	beds.save_spawns()
end