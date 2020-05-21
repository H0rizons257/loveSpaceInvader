function createLaser()
	laser = {}
	laser.sprite = love.graphics.newImage("sprites/laserBlue.png")
	laser.height = laser.sprite:getHeight()*SCALE
	laser.width = laser.sprite:getWidth()*SCALE
	laser.speed = 300
	
	return laser
end