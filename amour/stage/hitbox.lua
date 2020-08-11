local class = require "lib.lua-oop"

local HitboxUtil = require "amour.stage.hitbox.util"

require "amour.util"

local Hitbox = class("Hitbox")

function Hitbox:constructor(params, type)

    self.params = params

    if type then
        self.type = type
    else
        self.type = "axisaligned"
    end

end

function Hitbox:isHitting(other)

    if string.lower(self.type) == "axisaligned" then
        local position = self.params.position
        local size = self.params.size
        other = other.params
        return position.x < other.position.x + other.size.x and
               other.position.x < position.x + size.x and
               position.y < other.position.y + other.size.y and
               other.position.y < position.y + size.y
    elseif string.lower(self.type) == "rotated" then

        if not self.params.poly or not other.params.poly then
            return false
        end

        return HitboxUtil.doPolygonsIntersect(self.params.poly, other.params.poly)

    end

end

return Hitbox
