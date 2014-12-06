function doCollisions(dt)
	local i=1
	while i <= #player.projectiles do
		local ii=1
		while ii <= #targets do
			if player.projectiles[i] ~= nil then
				if player.projectiles[i].shape == "point" and targets[ii].shape == "circle" then
					hit = doCirclePointCollision(player.projectiles[i], targets[ii])
					
					if hit then
						targets[ii].health = targets[ii].health - player.projectiles[i].damage
						table.remove(player.projectiles, i)
						if targets[ii].health < 0 then
							table.remove(targets, ii)
						end
					end
				end
				ii = ii + 1
			else
				break
			end
		end
		i = i + 1
	end
end

function doCirclePointCollision(point, circle)
	dx = circle.x - point.x
	dy = circle.y - point.y
	
	return dx * dx + dy * dy <= circle.radius * circle.radius
end