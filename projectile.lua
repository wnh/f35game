Projectile = {}

function Projectile:new(speed, damage, hitbox, draw)
	o = {
		x = 0,
		y = 0,
		speed = speed,
		acceleration = 0,
		damage = damage,
		angle = 0,
		tracking = nil,
		hitbox = hitbox,
		draw = draw
	}
	setmetatable(o, self)
	self.__index = self
	return o
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