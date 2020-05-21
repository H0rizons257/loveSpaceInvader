function createLaser()
	laser = {}
	laser.sprite = love.graphics.newImage("sprites/laserBlue.png")
	laser.height = laser.sprite:getHeight()*SCALE
	laser.width = laser.sprite:getWidth()*SCALE
	laser.speed = 300
	
	laser.x = playerShip.x + playerShip.width/2 -laser.width/2
	laser.y = playerShip.y - laser.height
	return laser
end

function moveLaser (laser, dt)
	laser.y = laser.y - laser.speed*dt
end
