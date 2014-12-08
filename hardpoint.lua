Hardpoint = {
	cyclicRate = 0.1,
	xOffset = 0,
	yOffset = 0,
	lastFire = 0,
	firingAngle = 0,
	projectile = nil
}

function Hardpoint:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Hardpoint:init(cyclicRate, xOffset, yOffset, firingAngle, projectile)
	self.cyclicRate = cyclicRate
	self.xOffset = xOffset
	self.yOffset = yOffset
	self.firingAngle = firingAngle
	self.projectile = projectile
end

--[[weapons = {}
	
weapons["cannon"] = {
	hardpoints = {},
	frequency = 0.1,
	lastFire = 0,
	damage = 10
}	
table.insert(weapons.cannon.hardpoints, {
	offsetX = (player.ship.actualX / 2) - 30,
	offsetY = 100,
	width = 2,
	height = 5,
	speed = 1500,
	angle = 0
})
table.insert(weapons.cannon.hardpoints, {
	offsetX = (player.ship.actualX / 2) + 30,
	offsetY = 100,
	width = 2,
	height = 5,
	speed = 1500,
	angle = 0
})
table.insert(weapons.cannon.hardpoints, {
	offsetX = (player.ship.actualX / 2) + 30,
	offsetY = 100,
	width = 2,
	height = 5,
	speed = 1500,
	angle = 20
})
table.insert(weapons.cannon.hardpoints, {
	offsetX = (player.ship.actualX / 2) - 30,
	offsetY = 100,
	width = 2,
	height = 5,
	speed = 1500,
	angle = 340
})

weapons["turret"] = {
	hardpoints = {},
	frequency = 0.1,
	lastFire = 0,
	damage = 25
}	
table.insert(weapons.turret.hardpoints, {
	offsetX = (player.ship.actualX / 2) + 50,
	offsetY = 120,
	width = 2,
	height = 5,
	speed = 500,
	angle = 0
})
table.insert(weapons.turret.hardpoints, {
	offsetX = (player.ship.actualX / 2) - 50,
	offsetY = 120,
	width = 2,
	height = 5,
	speed = 500,
	angle = 0
})	

weapons["gatling"] = {
	hardpoints = {},
	frequency = 0.03,
	lastFire = 0,
	damage = 10
}	
table.insert(weapons.gatling.hardpoints, {
	offsetX = (player.ship.actualX / 2) + 15,
	offsetY = 50,
	width = 2,
	height = 5,
	speed = 1500,
	angle = 0
})
table.insert(weapons.gatling.hardpoints, {
	offsetX = (player.ship.actualX / 2) - 15,
	offsetY = 50,
	width = 2,
	height = 5,
	speed = 1500,
	angle = 0
})

weapons["missile"] = {
	hardpoints = {},
	frequency = 0.5,
	lastFire = 0,
	damage = 250
}	
table.insert(weapons.missile.hardpoints, {
	offsetX = (player.ship.actualX / 2) + 30,
	offsetY = 100,
	width = 8,
	height = 20,
	speed = 50,
	acceleration = 10;
	angle = 0
})

table.insert(weapons.missile.hardpoints, {
	offsetX = (player.ship.actualX / 2) - 51,
	offsetY = 100,
	width = 8,
	height = 20,
	speed = 50,
	acceleration = 10;
	angle = 0
})]]
