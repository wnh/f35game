desktopDimensionX, desktopDimensionY = love.window.getDesktopDimensions()

if fullScreen then
	workingDimensionX = desktopDimensionX
	workingDimensionY = desktopDimensionY
	love.window.setMode(workingDimensionX, workingDimensionY, {["fullscreen"]=true})
else
	workingDimensionX = desktopDimensionX - 200
	workingDimensionY = desktopDimensionY - 200
	love.window.setMode(workingDimensionX, workingDimensionY)
end

love.window.setTitle("Some cool title here")