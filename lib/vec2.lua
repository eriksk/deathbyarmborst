Vec2 = {}
Vec2.__index = Vec2

function Vec2.new(x, y)
	local v = {}
	setmetatable(v, Vec2)

	v.x = x or 0.0
	v.y = y or 0.0

	return v
end

function Vec2:angle()
	return math.atan2(self.y, self.x)
end