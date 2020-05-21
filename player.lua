function createPlayer()
playerShip = {}
playerShip.sprite = love.graphics.newImage("sprites/playerShip.png")
playerShip.height = playerShip.sprite:getHeight()*SCALE
playerShip.width = playerShip.sprite:getWidth()*SCALE
playerShip.speed = 200

playerShip.x = SCREEN_WIDTH/2 -playerShip.width/2
playerShip.y = SCREEN_HEIGHT - playerShip.height

function playerShip.move(dt)
	if playerShip.x <= 0 and dt < 0 then
		playerShip.x = 0
	elseif playerShip.x >= SCREEN_WIDTH - playerShip.width and dt > 0 then
		playerShip.x = SCREEN_WIDTH - playerShip.width
	else
		playerShip.x = playerShip.x + (playerShip.speed * dt)
	end
end

return playerShip
end