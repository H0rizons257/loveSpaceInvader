function createInvader(row, column)
invader = {}
invader.width=52
invader.height=42
invader.sprite = love.graphics.newImage("sprites/enemy"..row.."_"..column..".png")
invader.speed = 130

invader.x = invader.width/2 + invader.width*column
invader.y = row*invader.height
invader.alive = true
direction = 1

return invader
end

function moveInvader(invader, dt)
	
end

function detectSide(invader)
	if invader.alive then
		if invader.x <= 0 then
			direction = 1
			return true
		end
		if invader.x >= SCREEN_WIDTH - invader.width  then
			direction = -1
			return true
		end
	end
	return false
end


function detectLaserCollision(invader)
	for currentLaser=1,#lasers do
		local laser = lasers[currentLaser]
		if (laser.x + laser.width > invader.x and laser.x < invader.x + invader.width) and 
		(laser.y + laser.height > invader.y and laser.y < invader.y + invader.height) and 
		invader.alive == true
		then
			invader.alive = false
			table.remove(lasers, currentLaser)
			break
		end		
	end
end
