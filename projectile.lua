Projectile = {
	x = 0,
	y = 0,
	speed = 0,
	acceleration = 0,
	damage = 0,
	angle = nil,
	tracking = nil,
	hitbox = nil,
	draw = nil
}

function Projectile:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Projectile:init(speed, damage, hitbox, draw)
	self.speed = speed
	self.damage = damage
	self.hitbox = hitbox
	self.draw = draw
end

cannonProjectileHitbox = {
	hitboxType = "point",
	offsetX = 1,
	offsetY = 0,
}

cannonProjectileDraw = {
	drawType = "polygon",
	width = 2,
	height = 5
}