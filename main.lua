require("player")
require("invader")
require("laser")

SCALE = 0.5
BGM_VOLUME_HIGH = 0.2
BGM_VOLUME_LOW = 0.05
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
RELOAD_TIME = 0.7

laserSFX = love.audio.newSource("sfx_laser.ogg","static")
BGM = love.audio.newSource("POL-stealth-mode-short.wav","stream")

function love.load()
	love.window.setTitle("Space Invader")
	love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
	
	BGM:setLooping(true)
	BGM:setVolume(BGM_VOLUME_HIGH)
	BGM:play()
	
	playerShip = createPlayer()
	
	enemies = {}
	for row = 1, 4 do
		enemies[row] = {}
		for column = 1, 5 do
			enemies[row][column] = createInvader(row, column)
		end
	end
	
	lasers = {}
end
	
gameOver = false
reloadCooldown = 1
allDead = false

function love.keypressed(key)
	if gameOver == false then
		if key == "space" then
			if reloadCooldown > RELOAD_TIME then
			table.insert(lasers,createLaser())
			laserSFX:stop()
			laserSFX:play()
			reloadCooldown = 0
			end
		end
	end
end

function love.update(dt)
	if gameOver == false then
	
		reloadCooldown = reloadCooldown+dt
		
		if love.keyboard.isDown("left") then
			playerShip.move(-dt)
		elseif love.keyboard.isDown("right") then
			playerShip.move(dt)
		end
		
		changeDirection = false
		allDead = true
		for row=1,#enemies do
			for column=1,#enemies[row] do
				if(changeDirection == false) then
					changeDirection = detectSide(enemies[row][column])
				end
				
				detectLaserCollision(enemies[row][column])
				
				if enemies[row][column].alive then
					allDead = false
				end
			end
		end
		
		if allDead then
			gameOver = true
		return
		end
		
		for row=1,#enemies do
			for column=1,#enemies[row] do
				moveInvader(enemies[row][column], dt)
			end
		end
		
		for laser=1,#lasers do
			moveLaser(lasers[laser], dt)
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
			if invader.alive then
				love.graphics.draw(invader.sprite, invader.x, invader.y, 0, SCALE, SCALE)
			end
		end
	end
	
	for laser=1,#lasers do
			love.graphics.draw(lasers[laser].sprite, lasers[laser].x, lasers[laser].y, 0, SCALE, SCALE)
	end	
end

