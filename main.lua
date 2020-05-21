require("player")
require("invader")
require("laser")

SCALE = 0.5
BGM_VOLUME_HIGH = 0.2
BGM_VOLUME_LOW = 0.05
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
RELOAD_TIME = 0.7
background = love.graphics.newImage("sprites/background.png")
laserSFX = love.audio.newSource("sfx_laser.ogg","static")
BGM = love.audio.newSource("POL-stealth-mode-short.wav","stream")

BGM:setLooping(true)
BGM:setVolume(BGM_VOLUME_HIGH)
BGM:play()

function love.load()
	love.window.setTitle("Space Invader")
	love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
	--width, height = love.graphics.getDimensions()
	
	--Create player
	playerShip = createPlayer()
	
	--Create enemies
	enemies = {}
	for row = 1, 4 do
		enemies[row] = {}
		for column = 1, 5 do
			enemies[row][column] = createInvader(row, column)
		end
	end
	
	lasers = {}
end
	
reloadCooldown = 1
gameOver = false
allDead = false
paused = false
score = 0
scoreTimer = 0

function love.keypressed(key)
	--Shooting
	if gameOver == false and paused == false then
		if key == "space" then
			if reloadCooldown > RELOAD_TIME then
			table.insert(lasers,createLaser())
			laserSFX:stop()
			laserSFX:play()
			reloadCooldown = 0
			end
		end
	end
	
	--Pausing game
	if key == "escape" then
		if paused then 
			paused = false
			BGM:setVolume(0.2)
		else
			paused = true
			BGM:setVolume(0.05)
		end
	end
end

function love.update(dt)
	
	if gameOver == false and paused == false then

		reloadCooldown = reloadCooldown+dt
		scoreTimer = scoreTimer + dt
		--Reduce score
		if scoreTimer > 0.3 then
			scoreTimer = scoreTimer - 0.3
			if score > 0 then 
			score = score-1
			end
		end

		--Player movement
		if love.keyboard.isDown("left") then
			playerShip.move(-dt)
		elseif love.keyboard.isDown("right") then
			playerShip.move(dt)
		end
		
		--Invader checks
		changeDirection = false
		allDead = true
		for row=1,#enemies do
			for column=1,#enemies[row] do
				--Change direction
				if(changeDirection == false) then
					changeDirection = detectSide(enemies[row][column])
				end
				
				--Detect Laser
				detectLaserCollision(enemies[row][column])
				
				--Game Over
				if enemies[row][column].alive then
				allDead = false
				end
			end
		end
		
		if allDead then
			gameOver = true
		return
		end
		
		--Move Invaders
		for row=1,#enemies do
			for column=1,#enemies[row] do
				moveInvader(enemies[row][column], dt)
			end
		end

		--Move lasers
		for laser=1,#lasers do
			moveLaser(lasers[laser], dt)
			end
	end
end

function love.draw()
	
	--Background
	for num=0,3 do
		for num2=0,3 do
		love.graphics.draw(background, background:getHeight()*num, background:getWidth()*num2)
		end
	end

	if paused then 
		love.graphics.print("Paused", 0, 0)
	end
	
	if gameOver then 
		love.graphics.print("Game Over", 0, 0)
	end
	
	love.graphics.print("Score:"..score, SCREEN_WIDTH - 75, 0)
	
	--Player
	love.graphics.draw(playerShip.sprite, playerShip.x, playerShip.y, 0, SCALE, SCALE)
	
	--Enemies
	for row=1,#enemies do
        for column=1,#enemies[row] do
			local invader = enemies[row][column]
			if invader.alive then
			love.graphics.draw(invader.sprite, invader.x, invader.y, 0, SCALE, SCALE)
			end
		end
	end
	
	--Lasers
	for laser=1,#lasers do
			love.graphics.draw(lasers[laser].sprite, lasers[laser].x, lasers[laser].y, 0, SCALE, SCALE)
	end		
end

