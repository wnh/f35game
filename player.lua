player = {}
player["ship"] = {
	x = 0,
	y = 0,
	shields = 50,
	health = 100,
	scaleX = 0.6,
	scaleY = 0.6,
	image = love.graphics.newImage("playerShip.png")
}

-- calculate the ship starting position --
player.ship["imageX"] = player.ship.image:getWidth()
player.ship["imageY"] = player.ship.image:getHeight()
player.ship["actualX"] = player.ship.imageX * player.ship.scaleX
player.ship["actualY"] = player.ship.imageY * player.ship.scaleY
player.ship["startPointX"] = (workingDimensionX / 2) - (player.ship.actualX / 2)
player.ship["startPointY"] = (workingDimensionY - player.ship.actualY)
player.ship.x = player.ship.startPointX
player.ship.y = player.ship.startPointY

-- set up projectiles object --
player["projectiles"] = {}

-- cannon is the default weapon --
player["equippedWeapon"] = "cannon"