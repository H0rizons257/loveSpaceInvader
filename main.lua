require("player")

SCALE = 0.5
BGM_VOLUME_HIGH = 0.2
BGM_VOLUME_LOW = 0.05
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
RELOAD_TIME = 0.7


function love.load()
	love.window.setTitle("Space Invader")
	love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
	
	playerShip = createPlayer()
end
	

function love.update(dt)
	if love.keyboard.isDown("left") then
		playerShip.move(-dt)
	elseif love.keyboard.isDown("right") then
		playerShip.move(dt)
	end
end

function love.draw()
	love.graphics.draw(playerShip.sprite, playerShip.x, playerShip.y, 0, SCALE, SCALE)
end

