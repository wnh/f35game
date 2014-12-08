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

projectiles = {}

function projectiles:update(dt)
  if next(self) ~= nil then
    for key, thisProjectile in ipairs(self) do
      thisProjectile:update(dt)
    end
  end
end

function projectiles:draw()
    for key, thisProjectile in ipairs(self) do
      thisProjectile:draw()
    end
end

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

function Projectile:update(dt)
    scaleX = math.sin(math.rad(self.angle))
    scaleY = -math.cos(math.rad(self.angle))
    
    if self.acceleration ~= nil then
      self.speed = self.speed + self.acceleration
    end
    
    movementX = self.speed * scaleX
    movementY = self.speed * scaleY
    projectile.x = self.x + movementX*dt
    projectile.y = self.y + movementY*dt
end

function Projectile:draw()
  vertices = calculateCannonRectangle(self)
  love.graphics.polygon("fill", vertices)
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