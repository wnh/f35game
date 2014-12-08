debugOn = true
showFPS = true
fullScreen = false

require "window"
require "player"
require "projectile"
require "hardpoint"
require "weapons"

function love.load()
	playerShip = PlayerShip:new("playerShip.png", 0, 0)
	playerShip:setScale(0.5, 0.5)
	playerShip:calculateStartingPoint()
	player = Player:new(playerShip)
	
	cannon = Weapon:new("Mult-vector Chain Gun")
	--[[turret = Weapon:new("WT45 Auto-tracking Turret")
	gatling = Weapon:new("X491 Tank Buster")
	missiles = Weapon:new("T51 Air to Air Missiles")]]
	
	cannonProjectile = Projectile:new(1500, 10, cannonProjectileHitbox, cannonProjectileDraw)
	cannonHardpoint1 = Hardpoint:new(0.1, player.ship.width / 2 + 30, 100, 0, cannonProjectile)
	cannonHardpoint2 = Hardpoint:new(0.1, player.ship.width / 2 - 30, 100, 0, cannonProjectile)
	cannon:addHardpoint(cannonHardpoint1)
	cannon:addHardpoint(cannonHardpoint2)
	
	weapons:add(cannon)
	weapons:equip(1)

	--[[require "player"
	
	require "collision"
	
	targets = {}
	
	table.insert(targets, {
		shape = "circle",
		radius = 50,
		fill = "line",
		segments = 100,
		collisionDetection = true,
		collision = false,
		health = 1000,
		shields = 0,
		x = 500,
		y = 300,
		targetType = "ufo",
		image = love.graphics.newImage("badguy1.png")
	})
	
	love.graphics.setBackgroundColor(0, 0, 255)
	
	  id = love.image.newImageData(18, 18)
	  --1b. fill that blank image data
	  for x = 0, 17 do
		for y = 0, 17 do
		  local gradient = 1 - ((x-15)^2+(y-15)^2)/40
		  id:setPixel(x, y, 255, 255, 255, 255*(gradient<0 and 0 or gradient))
		end
	  end
	
  i = love.graphics.newImage("particle.png")
  p = love.graphics.newParticleSystem(i, 256)
  p:setEmissionRate(100)
  p:setEmitterLifetime(1.5)
  p:setParticleLifetime(0.5)
  p:setDirection(math.pi / 2)
  p:setSpread(0.5)
  p:setSpeed(100, 100)
  p:setSizes(1, 0.25)
  p:setSizeVariation(1)
  p:setColors(255, 96, 0, 240, 255, 255, 255, 10)
  p:stop()
	
	missileImage = love.graphics.newImage("missile.png")--]]
	
end

function love.update(dt)
	player:update(dt)
	weapons:update(dt)
--[[
	movePlayerShip(dt)
	moveTargets(dt)
	fireWeapons(dt)
	updateProjectiles(dt)
	doCollisions(dt)
	--]]
end

function love.draw()
	if showFPS then
		love.graphics.print("FPS: " .. love.timer.getFPS(), (workingDimensionX - 70), 10)
	end
	
	player.ship:draw()
	projectiles.draw()
	--[[
	love.graphics.print("Projectiles: " .. table.getn(player.projectiles), 10, 10)
	love.graphics.print("Equipped Weapon: " .. player.equippedWeapon, 10, 25)
	
	love.graphics.print("Press \"C\" to switch weapons", 10, 200)
	love.graphics.print("Press \"ESC\" to exit", 10, 215)
	
	drawTargets()
	drawProjectiles()
	love.graphics.draw(player.ship.image, player.ship.x, player.ship.y, 0, player.ship.scaleX, player.ship.scaleY)
	--]]
end

--[[function love.keypressed(key, isrepeat)
	if key == "c" then
		weaponController(key)
	end
	if key == "escape" then
      love.event.quit()
   end
end

function movePlayerShip(dt)
	if love.keyboard.isDown("w", "up") then
		if player.ship.y > 10 then
			player.ship.y = player.ship.y - 400*dt
		end
	end	
	
	if love.keyboard.isDown("s", "down") then
		if player.ship.y < (workingDimensionY - player.ship.actualY) then
			player.ship.y = player.ship.y + 400*dt
		end
	end
	
	if love.keyboard.isDown("d", "right") then
		if player.ship.x < (workingDimensionX - player.ship.actualX) then
			player.ship.x = player.ship.x + 400*dt
		end
	end	
	
	if love.keyboard.isDown("a", "left") then
		if player.ship.x > 0 then
			player.ship.x = player.ship.x - 400*dt
		end
	end
end

function drawTargets()
	if next(targets) ~= nil then
		for key, target in pairs(targets) do
			if target.shape == "circle" then
				love.graphics.circle(target.fill, target.x, target.y, target.radius, target.segments)
				--love.graphics.draw(target.image, target.x, target.y)
				love.graphics.print("HP: " .. target.health, target.x - 25, target.y)
			end
		end
	end
end

function moveTargets()

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
			
			if projectile.acceleration ~= nil then
				projectile.speed = projectile.speed + projectile.acceleration
			end
			
			movementX = projectile.speed * scaleX
			movementY = projectile.speed * scaleY
			projectile.x = projectile.x + movementX*dt
			projectile.y = projectile.y + movementY*dt
		end
	end
	
	-- update any particle systems
	if next(player.projectiles) ~= nil then
		for key, projectile in pairs(player.projectiles) do
			if projectile.particle ~= nil then
				projectile.particle:update(dt)
			end
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

			if projectile.projectileType == "missile" then
				love.graphics.draw(projectile.particle, projectile.x + 10, projectile.y + 40)
				love.graphics.draw(missileImage, projectile.x, projectile.y, 0, 0.75, 0.75)
				
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
		
	if player.equippedWeapon == "missile" then
		weapons.missile.lastFire = weapons.missile.lastFire + love.timer.getDelta()
		if weapons.missile.lastFire > weapons.missile.frequency then
			fireMissile()
			weapons.missile.lastFire = 0
		end
	end
end

function fireCannon()
	for key, hardpoint in pairs(weapons.cannon.hardpoints) do
		local projectile = {
			x = player.ship.x + hardpoint.offsetX,
			y = player.ship.y + hardpoint.offsetY,
			projectileType = "cannon",
			collision = false,
			shape = "point",
			speed = hardpoint.speed,
			angle = hardpoint.angle,
			width = hardpoint.width,
			height = hardpoint.height,
			damage = weapons.cannon.damage
		}
		
		table.insert(player.projectiles, projectile)
	end
end

function fireGatling()
	for key, hardpoint in pairs(weapons.gatling.hardpoints) do
		local projectile = {
			x = player.ship.x + hardpoint.offsetX,
			y = player.ship.y + hardpoint.offsetY,
			projectileType = "gatling",
			collision = false,
			shape = "point",
			speed = hardpoint.speed,
			angle = hardpoint.angle,
			width = hardpoint.width,
			height = hardpoint.height,
			damage = weapons.gatling.damage
		}
		
		table.insert(player.projectiles, projectile)
	end
end


function fireTurret()
	-- turret weapon will fire at the current mouse location.
	for key, hardpoint in pairs(weapons.turret.hardpoints) do
		local projectile = {
			x = player.ship.x + hardpoint.offsetX,
			y = player.ship.y + hardpoint.offsetY,
			projectileType = "turret",
			collision = false,
			shape = "point",
			speed = hardpoint.speed,
			angle = _calculateShipToMouseAngle(hardpoint),
			width = hardpoint.width,
			height = hardpoint.height,
			damage = weapons.turret.damage
		}
		
		table.insert(player.projectiles, projectile)
	end
end

function fireMissile()
	-- turret weapon will fire at the current mouse location.
	for key, hardpoint in pairs(weapons.missile.hardpoints) do
		local projectile = {
			x = player.ship.x + hardpoint.offsetX,
			y = player.ship.y + hardpoint.offsetY,
			projectileType = "missile",
			collision = false,
			shape = "point",
			speed = hardpoint.speed,
			angle = hardpoint.angle,
			width = hardpoint.width,
			height = hardpoint.height,
			damage = weapons.missile.damage,
			acceleration = hardpoint.acceleration,
			particle = p:clone()
		}
		
		projectile.particle:start()
		
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
	
	local angle = math.deg(math.atan2(mouseY - (player.ship.y + hardpoint.offsetY), mouseX - (player.ship.x + hardpoint.offsetX)))
	
	if angle < 0 then
		angle = angle + 360
	end
	
	angle = angle + 90
	
	return angle
end --]]