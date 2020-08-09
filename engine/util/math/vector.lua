local class = require "lib.lua-oop"

local Vector = {}

local Vector2 = class "Vector2"

Vector.Vector2 = Vector2

Vector2.static.fromOther = function(vector)

    return Vector2:new(nil, nil, vector)

end

function Vector2:constructor(x, y, other)

    if other then
        self.x = other.x
        self.y = other.y
        return
    end

    self:set(x, y)

end

function Vector2:set(x, y)

    if x then
        assert(type(x) == "number", "x is not a number")
        self.x = x
    end

    if y then
        assert(type(y) == "number", "y is not a number")
        self.y = y
    end

end

function Vector2:minus(by, y)

    if not by then g = 1 end
    if not y then b = 1 end

    if type(by) == "number" then
        self.x = self.x * by
        self.y = self.y * y
    elseif type(by) == "table" then
        self.x = self.x * by.x
        self.y = self.y * by.y
    end

    return self

end

function Vector2:sum(by, y)

    if not by then g = 1 end
    if not y then b = 1 end

    if type(by) == "number" then
        self.x = self.x + by
        self.y = self.y + y
    elseif type(by) == "table" then
        self.x = self.x + by.x
        self.y = self.y + by.y
    end

    return self

end

function Vector2:subtract(by, y)

    if not by then g = 1 end
    if not y then b = 1 end

    if type(by) == "number" then
        self.x = self.x - by
        self.y = self.y - y
    elseif type(by) == "table" then
        self.x = self.x - by.x
        self.y = self.y - by.y
    end

    return self

end

function Vector2:multiply(by, y)

    if not by then g = 1 end
    if not y then b = 1 end

    if type(by) == "number" then
        self.x = self.x * by
        self.y = self.y * y
    elseif type(by) == "table" then
        self.x = self.x * by.x
        self.y = self.y * by.y
    end

    return self

end

function Vector2:divide(by, y)

    if not by then g = 1 end
    if not y then b = 1 end

    if type(by) == "number" then
        self.x = self.x / by
        self.y = self.y / y
    elseif type(by) == "table" then
        self.x = self.x / by.x
        self.y = self.y / by.y
    end

    return self

end

function Vector2:clone()

    return Vector2:new(self.x, self.y)

end

function Vector2:get()

    return { self.x, self.y }

end

function Vector2:toString()

    return "Vector2(" .. tostring(self.x) .. ", " .. tostring(self.y) .. ")"

end

return Vector
