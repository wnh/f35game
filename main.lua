debugOn = true
showFPS = true

function love.load()
	playerShip = {
		x = 0,
		y = 0,
		shields = 50,
		health = 100,
		scaleX = 0.15,
		scaleY = 0.15,
		image = love.graphics.newImage("playerShip.png")
	}
	
	playerShip["imageX"] = playerShip.image:getWidth()
	playerShip["imageY"] = playerShip.image:getHeight()
	
	playerShip["actualX"] = playerShip.imageX * playerShip.scaleX
	playerShip["actualY"] = playerShip.imageY * playerShip.scaleY
	
	
	if debugOn then
		print("player ship image dimension X " .. playerShip.imageX)
		print("player ship image dimension Y " .. playerShip.imageY)

		print("player ship actual dimension X " .. playerShip.actualX)
		print("player ship actual dimension Y " .. playerShip.actualY)
	end
	
	desktopDimensionX, desktopDimensionY = love.window.getDesktopDimensions()
	
	-- for testing, not full screen
	--workingDimensionX = desktopDimensionX - 200
	--workingDimensionY = desktopDimensionY - 200
	
	-- for full screen
	workingDimensionX = desktopDimensionX
	workingDimensionY = desktopDimensionY
	
	playerShip["startPointX"] = (workingDimensionX / 2) - (playerShip.actualX / 2)
	playerShip["startPointY"] = (workingDimensionY - playerShip.actualY)
	
	playerShip.x = playerShip.startPointX
	playerShip.y = playerShip.startPointY
	
	if debugOn then
		print("desktop dimension X " .. desktopDimensionX)
		print("desktop dimension Y " .. desktopDimensionY)
		print("working dimension X " .. workingDimensionX)
		print("working dimension Y " .. workingDimensionY)

		print("player ship starting point X " .. playerShip.startPointX)
		print("player ship starting point Y " .. playerShip.startPointY)
	end
	
	love.window.setMode(workingDimensionX, workingDimensionY, {["fullscreen"]=true})
	--love.window.setMode(workingDimensionX, workingDimensionY)
	love.window.setTitle("Some cool title here")
	
	player = {}
	player["projectiles"] = {}
	
	-- equipped weapon will be used later, for now it's just "cannon"
	player["equippedWeapon"] = "cannon"
	
	weapons = {}
	
	weapons["cannon"] = {
		hardpoints = {},
		frequency = 0.15,
		lastFire = 0
	}	
	table.insert(weapons.cannon.hardpoints, {
		offsetX = (playerShip.actualX / 2) - 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
	table.insert(weapons.cannon.hardpoints, {
		offsetX = (playerShip.actualX / 2) + 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
	table.insert(weapons.cannon.hardpoints, {
		offsetX = (playerShip.actualX / 2) + 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 20
	})
	table.insert(weapons.cannon.hardpoints, {
		offsetX = (playerShip.actualX / 2) - 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 340
	})
	
	weapons["turret"] = {
		hardpoints = {},
		frequency = 0.1,
		lastFire = 0
	}	
	table.insert(weapons.turret.hardpoints, {
		offsetX = (playerShip.actualX / 2) + 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
	table.insert(weapons.turret.hardpoints, {
		offsetX = (playerShip.actualX / 2) - 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})	
	
	weapons["gatling"] = {
		hardpoints = {},
		frequency = 0.04,
		lastFire = 0
	}	
	table.insert(weapons.gatling.hardpoints, {
		offsetX = (playerShip.actualX / 2) + 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
	table.insert(weapons.gatling.hardpoints, {
		offsetX = (playerShip.actualX / 2) - 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})

end

function love.update(dt)
	movePlayerShip(dt)
	fireWeapons(dt)
	updateProjectiles(dt)
end

function love.keypressed(key, isrepeat)
	if key == "c" then
		weaponController(key)
	end
	if key == "escape" then
      love.event.quit()
   end
end

function love.draw()
    love.graphics.draw(playerShip.image, playerShip.x, playerShip.y, 0, playerShip.scaleX, playerShip.scaleY)
	
	if showFPS then
		love.graphics.print("FPS: " .. love.timer.getFPS(), (workingDimensionX - 70), 10)
	end
	
	love.graphics.print("Projectiles: " .. table.getn(player.projectiles), 10, 10)
	love.graphics.print("Equipped Weapon: " .. player.equippedWeapon, 10, 25)
	
	love.graphics.print("Press \"C\" to switch weapons", 10, 200)
	love.graphics.print("Press \"ESC\" to exit", 10, 215)
	
	drawProjectiles()
end

function movePlayerShip(dt)
	if love.keyboard.isDown("w", "up") then
		if playerShip.y > 10 then
			playerShip.y = playerShip.y - 400*dt
		end
	end	
	
	if love.keyboard.isDown("s", "down") then
		if playerShip.y < (workingDimensionY - playerShip.actualY) then
			playerShip.y = playerShip.y + 400*dt
		end
	end
	
	if love.keyboard.isDown("d", "right") then
		if playerShip.x < (workingDimensionX - playerShip.actualX) then
			playerShip.x = playerShip.x + 400*dt
		end
	end	
	
	if love.keyboard.isDown("a", "left") then
		if playerShip.x > 0 then
			playerShip.x = playerShip.x - 400*dt
		end
	end
end

function weaponController(key)
	if key == "c" then
		local foundCurrent = false
		local weaponChanged = false
		local firstWeapon = ""
		for weapon, details in pairs(weapons) do
			if firstWeapon == "" then
				firstWeapon = weapon
			end

			-- found current was set in previous loop, so this must be the next weapon, let's equip it.
			if foundCurrent then
				player.equippedWeapon = weapon
				weaponChanged = true
				break
			end
		
			if weapon == player.equippedWeapon then
				foundCurrent = true
			end
		end
		
		-- we got to the end, found the current, but didn't switch the weapon, must have been on the last weapon in the list. Set the weapon to the first weapon in the list.
		if foundCurrent and not weaponChanged then
			player.equippedWeapon = firstWeapon
		end
	end	
end

function updateProjectiles(dt)
	
	-- do movement calculations
	if next(player.projectiles) ~= nil then
		for key, projectile in pairs(player.projectiles) do
			scaleX = math.sin(math.rad(projectile.angle))
			scaleY = -math.cos(math.rad(projectile.angle))
			movementX = projectile.speed * scaleX
			movementY = projectile.speed * scaleY
			projectile.x = projectile.x + movementX*dt
			projectile.y = projectile.y + movementY*dt
		end
	end
	
	-- delete any objects that were removed from screen
	if next(player.projectiles) ~= nil then
		local i=1
		while i <= #player.projectiles do
			if player.projectiles[i].x < 0 or player.projectiles[i].x > workingDimensionX or player.projectiles[i].y < 0 or player.projectiles[i].y > workingDimensionY then
				table.remove(player.projectiles, i)
			end
			i = i + 1
		end
	end
end

function drawProjectiles()
	if next(player.projectiles) ~= nil then
		for key, projectile in pairs(player.projectiles) do
			-- for now, cannon, turret and gatling are drawn the same
			if projectile.projectileType == "cannon" or projectile.projectileType == "turret" or projectile.projectileType == "gatling" then
				vertices = calculateCannonRectangle(projectile)
				love.graphics.polygon("fill", vertices)
			end			
		end
	end
end

function fireWeapons(dt)
	if player.equippedWeapon == "cannon" then
		weapons.cannon.lastFire = weapons.cannon.lastFire + love.timer.getDelta()
		if weapons.cannon.lastFire > weapons.cannon.frequency then
			fireCannon()
			weapons.cannon.lastFire = 0
		end
	end
	
	if player.equippedWeapon == "turret" then
		weapons.turret.lastFire = weapons.turret.lastFire + love.timer.getDelta()
		if weapons.turret.lastFire > weapons.turret.frequency then
			fireTurret()
			weapons.turret.lastFire = 0
		end
	end	
	
	if player.equippedWeapon == "gatling" then
		weapons.gatling.lastFire = weapons.gatling.lastFire + love.timer.getDelta()
		if weapons.gatling.lastFire > weapons.gatling.frequency then
			fireGatling()
			weapons.gatling.lastFire = 0
		end
	end
end

function fireCannon()
	for key, hardpoint in pairs(weapons.cannon.hardpoints) do
		local projectile = {
			x = playerShip.x + hardpoint.offsetX,
			y = playerShip.y + hardpoint.offsetY,
			projectileType = "cannon",
			collision = false,
			speed = hardpoint.speed,
			angle = hardpoint.angle,
			width = hardpoint.width,
			height = hardpoint.height
		}
		
		table.insert(player.projectiles, projectile)
	end
end

function fireGatling()
	for key, hardpoint in pairs(weapons.gatling.hardpoints) do
		local projectile = {
			x = playerShip.x + hardpoint.offsetX,
			y = playerShip.y + hardpoint.offsetY,
			projectileType = "gatling",
			collision = false,
			speed = hardpoint.speed,
			angle = hardpoint.angle,
			width = hardpoint.width,
			height = hardpoint.height
		}
		
		table.insert(player.projectiles, projectile)
	end
end


function fireTurret()
	-- turret weapon will fire at the current mouse location.
	for key, hardpoint in pairs(weapons.turret.hardpoints) do
		local projectile = {
			x = playerShip.x + hardpoint.offsetX,
			y = playerShip.y + hardpoint.offsetY,
			projectileType = "turret",
			collision = false,
			speed = hardpoint.speed,
			angle = _calculateShipToMouseAngle(hardpoint),
			width = hardpoint.width,
			height = hardpoint.height
		}
		
		table.insert(player.projectiles, projectile)
	end
end

function calculateCannonRectangle(projectile)
	local polyCenterX = projectile.x
	local polyCenterY = projectile.y
	local polyWidth = projectile.width
	local polyHeight = projectile.height
	
	x1 = polyCenterX - (polyWidth / 2)
	y1 = polyCenterY - (polyHeight / 2)
	x2 = polyCenterX + (polyWidth / 2)
	y2 = polyCenterY - (polyHeight / 2)
	x3 = polyCenterX + (polyWidth / 2)
	y3 = polyCenterY + (polyHeight / 2)
	x4 = polyCenterX - (polyWidth / 2)
	y4 = polyCenterY + (polyHeight / 2)
	
	if projectile.angle ~= 0 then
		x1r, y1r = rotatePoint(x1, y1, polyCenterX, polyCenterY, projectile.angle)
		x2r, y2r = rotatePoint(x2, y2, polyCenterX, polyCenterY, projectile.angle)
		x3r, y3r = rotatePoint(x3, y3, polyCenterX, polyCenterY, projectile.angle)
		x4r, y4r = rotatePoint(x4, y4, polyCenterX, polyCenterY, projectile.angle)
		
		return {x1r, y1r, x2r, y2r, x3r, y3r, x4r, y4r}
	end
	
	return {x1, y1, x2, y2, x3, y3, x4, y4}
end

function rotatePoint(pointX, pointY, originX, originY, angle)
	local angle = angle * math.pi / 180.0
	
	x = math.cos(angle) * (pointX-originX) - math.sin(angle) * (pointY-originY) + originX
	y = math.sin(angle) * (pointX-originX) + math.cos(angle) * (pointY-originY) + originY
	
	return x, y
end

function _calculateShipToMouseAngle(hardpoint)
	mouseX = love.mouse.getX()
	mouseY = love.mouse.getY()
	
	print("mouse x: " .. mouseX)
	print("mouse y: " .. mouseY)
	
	local angle = math.deg(math.atan2(mouseY - (playerShip.y + hardpoint.offsetY), mouseX - (playerShip.x + hardpoint.offsetX)))
	
	if angle < 0 then
		angle = angle + 360
	end
	
	angle = angle + 90
	
	return angle
end