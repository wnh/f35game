-- keep this around as a reminder of how to type check --
-- assert(tostring(image) == "Image", "expecting type Image, got " .. tostring(image))

Player = {}

function Player:new(ship)
  o = {
  	level = 0,
	experience = 0,
	ship = ship
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Player:update(dt)
	self.ship:update(dt)
end

PlayerShip = {}

function PlayerShip:new(image, x, y)
  o = {
  	image = love.graphics.newImage(image),
	x = x,
	y = y,
	scaleX = 1,
	scaleY = 1,
	width = nil,
	height = nil,
	movementSpeed = 1000
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function PlayerShip:setDimensions(width, height)
	self.width = width
	self.height = height
	local widthTemp = self.image:getWidth()
	local heightTemp = self.image:getHeight()
	self.scaleX = self.width / widthTemp
	self.scaleY = self.height / heightTemp
end

function PlayerShip:setScale(scaleX, scaleY)
	self.scaleX = scaleX
	self.scaleY = scaleY
	local widthTemp = self.image:getWidth()
	local heightTemp = self.image:getHeight()
	self.width = widthTemp * self.scaleX
	self.height = heightTemp * self.scaleY
end

function PlayerShip:setMovementSpeed(speed)
	self.movementSpeed = speed
end

function PlayerShip:calculateStartingPoint()
	self.x = (workingDimensionX / 2) - (self.width / 2)
	self.y = workingDimensionY - self.height
end

function PlayerShip:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, self.scaleX, self.scaleY)
end

function PlayerShip:update(dt)
	if love.keyboard.isDown("w", "up") then
		if self.y > 10 then
			self.y = self.y - self.movementSpeed * dt
		end
	end	
	
	if love.keyboard.isDown("s", "down") then
		if self.y < (workingDimensionY - self.height) then
			self.y = self.y + self.movementSpeed * dt
		end
	end
	
	if love.keyboard.isDown("d", "right") then
		if self.x < (workingDimensionX - self.width) then
			self.x = self.x + self.movementSpeed * dt
		end
	end	
	
	if love.keyboard.isDown("a", "left") then
		if self.x > 0 then
			self.x = self.x - self.movementSpeed * dt
		end
	end
end

function PlayerShip:updateCoords(x, y)
	self.x = x
	self.y = y
end

function PlayerShip:getCoords()
	return self.x, self.y
end