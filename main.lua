require "lib/vec2"
require "lib/sprite"
require "lib/rectangle"
--require "lib/road"

function love.load()
	width = 800
	height = 600
	texture_filter = "nearest"
	road = load_image("road")
	road_y = 0
	friction = 0.002
	speed = 0.1

	bush = load_image("bush")
	grass = load_image("grass")
	car = Sprite.new("car")
	car.speed = 0.003
	car.boundary = Rectangle.new(((width / 2.0) - 128) + 16, 0, 256 - 32, height)
end

function  load_image(name)
	return love.graphics.newImage("content/gfx/" .. name .. ".png")
end

function apply_friction(sprite, dt)
	if sprite.velocity.x > 0.0 then
		sprite.velocity.x = sprite.velocity.x - friction * dt
		if sprite.velocity.x < 0.0 then
			sprite.velocity.x = 0.0
		end
	end
	if sprite.velocity.x < 0.0 then
		sprite.velocity.x = sprite.velocity.x + friction * dt
		if sprite.velocity.x > 0.0 then
			sprite.velocity.x = 0.0
		end
	end
	if sprite.velocity.y > 0.0 then
		sprite.velocity.y = sprite.velocity.y - friction * dt
		if sprite.velocity.y < 0.0 then
			sprite.velocity.y = 0.0
		end
	end
	if sprite.velocity.y < 0.0 then
		sprite.velocity.y = sprite.velocity.y + friction * dt
		if sprite.velocity.y > 0.0 then
			sprite.velocity.y = 0.0
		end
	end
end

function clamp_to_rectangle(sprite, rectangle)
	if sprite.position.x < rectangle:left() then
		sprite.position.x = rectangle:left() 
	end
	if sprite.position.x > rectangle:right() then
		sprite.position.x = rectangle:right() 
	end
	if sprite.position.y < rectangle:top() then
		sprite.position.y = rectangle:top() 
	end
	if sprite.position.y > rectangle:bottom() then
		sprite.position.y = rectangle:bottom() 
	end
end

function love.update()
	dt = 16.0

	if love.keyboard.isDown("escape") then
		love.event.push("quit")
	end

	if love.keyboard.isDown("up") then
		car.velocity.y = car.velocity.y - car.speed * dt
	end
	if love.keyboard.isDown("down") then
		car.velocity.y = car.velocity.y + car.speed * dt
	end
	if love.keyboard.isDown("left") then
		car.velocity.x = car.velocity.x - car.speed * dt
	end
	if love.keyboard.isDown("right") then
		car.velocity.x = car.velocity.x + car.speed * dt
	end

	road_y = road_y + speed * dt
	if road_y >= 0.0 then
		road_y = -128 * 8
	end

	apply_friction(car, dt)
	car:update(dt)
	clamp_to_rectangle(car, car.boundary)
end

function love.draw()
	for i=0,13 do
		love.graphics.draw(grass, 32, (road_y + 128 * i) / 1)
		love.graphics.draw(grass, (width / 2.0) + 128, (road_y + 128 * i) / 1)
		love.graphics.draw(road, (width / 2.0) - 128, (road_y + 128 * i) / 1)
		love.graphics.draw(bush, 128 + 64, (road_y + 128 * i) / 1)
		love.graphics.draw(bush, 128 + 256 + 128 + 32, (road_y + 128 * i) / 1)
	end

	love.graphics.print("Road: " .. road_y, 16, 16)
	love.graphics.print("Speed: " .. speed, 16, 32)

	car:draw()
end