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
	
	workingDimensionX = desktopDimensionX - 200;
	workingDimensionY = desktopDimensionY - 200;
	
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
	
	--love.window.setMode(desktopDimensionWidth - 200, desktopDimensionHeight - 200, {["fullscreen"]=true})
	love.window.setMode(desktopDimensionX - 200, desktopDimensionY - 200)
	love.window.setTitle("Some cool title here")
	
	player = {}
	player["projectiles"] = {}
	table.insert(player.projectiles, {
		x = 500,
		y = 500,
		projectileType = nil,
		collision = false,
		onScreen = true,
		speed = 5,
		angle = 45
	})
	
	-- equipped weapon will be used later, for now it's just "cannon"
	player["equippedWeapon"] = "cannon"

end

function love.update()
	print("update")
	movePlayerShip()
	updateProjectiles()
end

function love.draw()
print("draw")
    love.graphics.draw(playerShip.image, playerShip.x, playerShip.y, 0, playerShip.scaleX, playerShip.scaleY)
	
	if showFPS then
		love.graphics.print("FPS: " .. love.timer.getFPS(), (workingDimensionX - 70), 10)
	end
	
	drawProjectiles()
end

function movePlayerShip()
	if love.keyboard.isDown("up") then
		if playerShip.y > 10 then
			playerShip.y = playerShip.y - 10
		end
	end	
	
	if love.keyboard.isDown("down") then
		if playerShip.y < (workingDimensionY - playerShip.actualY) then
			playerShip.y = playerShip.y + 10
		end
	end
	
	if love.keyboard.isDown("right") then
		if playerShip.x < (workingDimensionX - playerShip.actualX) then
			playerShip.x = playerShip.x + 10
		end
	end	
	
	if love.keyboard.isDown("left") then
		if playerShip.x > 0 then
			playerShip.x = playerShip.x - 10
		end
	end
end

function updateProjectiles()
	blankProjectile = {
		x = 0,
		y = 0,
		projectileType = nil,
		collision = false,
		onScreen = true,
		speed = 1,
		angle = 0
	}
	
	-- do movement calculations
	if player.equippedWeapon == "cannon" then
		if next(player.projectiles) ~= nil then
			for key, projectile in pairs(player.projectiles) do
				scaleX = math.sin(math.rad(projectile.angle))
				scaleY = -math.cos(math.rad(projectile.angle))
				movementX = projectile.speed * scaleX
				movementY = projectile.speed * scaleY
				projectile.x = projectile.x + movementX
				projectile.y = projectile.y + movementY
				
				print("currentX: " .. projectile.x)
				print("currentY: " .. projectile.y)
			end
		end
	end
	
	-- delete any objects that were removed from screen
	if next(player.projectiles) ~= nil then
		for key, projectile in pairs(player.projectiles) do
			if projectile.x < 0 or projectile.x > workingDimensionX or projectile.y < 0 or projectile.y > workingDimensionY then
				player.projectiles[key] = nil
			end
			
			print("currentX: " .. projectile.x)
			print("currentY: " .. projectile.y)
		end
	end
end

function drawProjectiles()
	if next(player.projectiles) ~= nil then
		for key, projectile in pairs(player.projectiles) do
		print("drawing at x: " .. projectile.x)
		print("drawing at y: " .. projectile.y)
			love.graphics.circle("fill", projectile.x, projectile.y, 10, 25)
		end
	end
end