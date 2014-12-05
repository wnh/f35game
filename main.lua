function love.load()
	playerShipX = 300
	playerShipY = 300
	playerShipShields = 100
	playerShipHealth = 100
	playerShipImage = love.graphics.newImage("playerShip.png")
	playerShipImageScaleX = 0.15
	playerShipImageScaleY = 0.15
	playerShipImageDimensionX = playerShipImage:getWidth()
	playerShipImageDimensionY = playerShipImage:getHeight()
	playerShipActualDimensionX = playerShipImageDimensionX * playerShipImageScaleX
	playerShipActualDimensionY = playerShipImageDimensionY * playerShipImageScaleY
	
	
	desktopDimensionWidth, desktopDimensionHeight = love.window.getDesktopDimensions()
	
	--love.window.setMode(desktopDimensionWidth - 200, desktopDimensionHeight - 200, {["fullscreen"]=true})
	love.window.setMode(desktopDimensionWidth - 200, desktopDimensionHeight - 200)
	
	love.window.setTitle("Some cool title here")

end

function love.update()
	movePlayerShip()
end

function love.draw()
    love.graphics.draw(playerShipImage, playerShipX, playerShipY, 0, playerShipImageScaleX, playerShipImageScaleY)
end

function movePlayerShip()
	if love.keyboard.isDown("up") then
		playerShipY = playerShipY - 10
	end	
	
	if love.keyboard.isDown("down") then
		playerShipY = playerShipY + 10
	end
	
	if love.keyboard.isDown("right") then
		playerShipX = playerShipX + 10
	end	
	
	if love.keyboard.isDown("left") then
		playerShipX = playerShipX - 10
	end
end