weapons = {}
	
	weapons["cannon"] = {
		hardpoints = {},
		frequency = 0.15,
		lastFire = 0
	}	
	table.insert(weapons.cannon.hardpoints, {
		offsetX = (playerShip.actualX / 2) - 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
	table.insert(weapons.cannon.hardpoints, {
		offsetX = (playerShip.actualX / 2) + 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
	table.insert(weapons.cannon.hardpoints, {
		offsetX = (playerShip.actualX / 2) + 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 20
	})
	table.insert(weapons.cannon.hardpoints, {
		offsetX = (playerShip.actualX / 2) - 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 340
	})
	
	weapons["turret"] = {
		hardpoints = {},
		frequency = 0.1,
		lastFire = 0
	}	
	table.insert(weapons.turret.hardpoints, {
		offsetX = (playerShip.actualX / 2) + 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
	table.insert(weapons.turret.hardpoints, {
		offsetX = (playerShip.actualX / 2) - 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})	
	
	weapons["gatling"] = {
		hardpoints = {},
		frequency = 0.04,
		lastFire = 0
	}	
	table.insert(weapons.gatling.hardpoints, {
		offsetX = (playerShip.actualX / 2) + 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
	table.insert(weapons.gatling.hardpoints, {
		offsetX = (playerShip.actualX / 2) - 30,
		offsetY = 60,
		width = 2,
		height = 5,
		speed = 500,
		angle = 0
	})
