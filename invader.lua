function createInvader(row, column)
	invader = {}
	invader.width=52
	invader.height=42
	invader.sprite = love.graphics.newImage("sprites/enemy"..row.."_"..column..".png")
	invader.speed = 130

	invader.x = invader.width/2 + invader.width*column
	invader.y = row*invader.height
	direction = 1
	
	return invader
end

function moveInvader(invader, dt)
	invader.x = invader.x + (invader.speed * dt * direction)
	if changeDirection then
		invader.y = invader.y + invader.height
		if invader.y + invader.height > SCREEN_HEIGHT - playerShip.height then
			gameOver = true
		end
	end
end

function detectSide(invader)	
	if invader.x <= 0 then
		direction = 1
		return true
	end
	if invader.x >= SCREEN_WIDTH - invader.width  then
		direction = -1
		return true
	end
	return false
end