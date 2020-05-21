require("player")
require("invader")

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
	
	enemies = {}
	for row = 1, 4 do
		enemies[row] = {}
		for column = 1, 5 do
			enemies[row][column] = createInvader(row, column)
		end
	end
end
	
gameOver = false

function love.update(dt)
	if gameOver == false then
	
		if love.keyboard.isDown("left") then
			playerShip.move(-dt)
		elseif love.keyboard.isDown("right") then
			playerShip.move(dt)
		end
		
		changeDirection = false
		for row=1,#enemies do
			for column=1,#enemies[row] do
				if(changeDirection == false) then
					changeDirection = detectSide(enemies[row][column])
				end
			end
		end
		
		for row=1,#enemies do
			for column=1,#enemies[row] do
				moveInvader(enemies[row][column], dt)
			end
		end
	end
end

function love.draw()
	love.graphics.draw(playerShip.sprite, playerShip.x, playerShip.y, 0, SCALE, SCALE)
	
	if gameOver then 
		love.graphics.print("Game Over", 0, 0)
	end
	
	for row=1,#enemies do
        for column=1,#enemies[row] do
			local invader = enemies[row][column]
			love.graphics.draw(invader.sprite, invader.x, invader.y, 0, SCALE, SCALE)
		end
	end
end

