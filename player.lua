function createPlayer()
playerShip = {}
playerShip.sprite = love.graphics.newImage("sprites/playerShip.png")
playerShip.height = playerShip.sprite:getHeight()*SCALE
playerShip.width = playerShip.sprite:getWidth()*SCALE
playerShip.speed = 200

return playerShip
end