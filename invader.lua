function createInvader(row, column)
	invader = {}
	invader.width=52
	invader.height=42
	invader.sprite = love.graphics.newImage("sprites/enemy"..row.."_"..column..".png")
	invader.speed = 130

	return invader
end