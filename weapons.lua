weapons = {}

function weapons:add(weapon)
	table.insert(self, weapon)
end

function weapons:update(dt)
	print(table.getn(self))
	for key, thisWeapon in ipairs(self) do
		if thisWeapon.equipped == true then
			print("firing: " .. thisWeapon.prettyName)
		end
	end
end

function weapons:equip(index)
	self[index].equipped = true
end

Weapon = {
	equipped = false,
	hardpoints = {},
	prettyName = ""
}

function Weapon:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Weapon:setPrettyName(name)
	self.prettyName = name
end

function Weapon:addHardpoint(hardpoint)
	table.insert(self.hardpoints, hardpoint)
end

function Weapon:update(dt)
	
end