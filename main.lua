require "lib/vec2"
require "lib/sprite"
--require "lib/road"

function love.load()
	width = 800
	height = 600
	road = load_image("road")
	road_y = 0
	speed = 0.1
end

function  load_image(name)
	return love.graphics.newImage("content/gfx/" .. name .. ".png")
end

function love.update()
	dt = 16.0

	if love.keyboard.isDown("escape") then
		love.event.push("quit")
	end
	if love.keyboard.isDown("up") then
		speed = speed + 0.001 * dt
	end
	if love.keyboard.isDown("down") then
		speed = speed - 0.001 * dt
	end

	road_y = road_y + speed * dt
	if road_y >= 0.0 then
		road_y = -128 * 8
	end
end

function love.draw()
	for i=0,13 do
		love.graphics.draw(road, (width / 2.0) - 128, (road_y + 128 * i) / 1)
	end

	love.graphics.print("Road: " .. road_y, 16, 16)
	love.graphics.print("Speed: " .. speed, 16, 32)
end