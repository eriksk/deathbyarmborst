Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle.new(x, y, width, height)
	local s = {}
	setmetatable(s, Rectangle)

	s.x = x or 0
	s.y = y or 0
	s.width = width or 0
	s.height = height or 0

	return s
end

function Rectangle:left()
	return self.x
end
function Rectangle:right()
	return self.x + self.width
end
function Rectangle:top()
	return self.y
end
function Rectangle:bottom()
	return self.y + self.height
end