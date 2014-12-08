weapons = {}

function weapons:add(weapon)
	table.insert(self, weapon)
end

function weapons:update(dt)
	for key, thisWeapon in ipairs(self) do
		if thisWeapon.equipped == true then
			thisWeapon:update(dt)
		end
	end
end

function weapons:equip(index)
	self[index].equipped = true
end

Weapon = {}

function Weapon:new(prettyName)
	o = {
		equipped = false,
		hardpoints = {},
		prettyName = prettyName
	}
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
	print("we're in update")
end