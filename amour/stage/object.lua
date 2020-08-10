local class = require "lib.lua-oop"

StageObject = class "StageObject"

function StageObject:constructor(position, rotation, size, color)

    self.isFirstUpdate = true
    self.enabled = true
    self.visible = true

    self.tPos = position
    self.tRot = rotation
    self.tSize = size
    self.tCol = color

end

function StageObject:init() end

function StageObject:_init()

    self.parentStage.modules.declare()

    self.rotation = 0
    self.hitbox = Hitbox:new(position, size)

    self:setPosition(self.tPos)
    self:setRotation(self.tRot)
    self:setOffset()
    self:setSize(self.tSize)
    self:setColor(self.tCol)

    self.tPos = nil
    self.tRot = nil
    self.tSize = nil
    self.tCol = nil

end

function StageObject:stageInit() end

function StageObject:firstUpdate() end

function StageObject:firstStageUpdate() end

function StageObject:update(dt) end

function StageObject:_update(dt)

    if self.isFirstUpdate then

        print("First update of " .. self.parentStage.class.name .. "/" .. self.class.name .. " (object)")

        self:firstUpdate()

        self:_init()

        self.isFirstUpdate = false

    end

    -- Clip offset from 0-1
    local x = Math.clip(self.offset.x, 0, 1)
    local y = Math.clip(self.offset.y, 0, 1)
    self.offset:set(x, y)

    self:update(dt)

    self:updateHitbox()

end

function StageObject:draw() end

function StageObject:beforeChange(nextStage) end

function StageObject:setPosition(position)

        if position then
            assert(type(position) == "table", "Position is not an object (StageObject)")
            self.position = position:clone()
        else
            self.position = Geometry.Vector2:new(0, 0)
        end

end

function StageObject:setSize(size)

        if size then
            assert(type(size) == "table", "Size is not an object (StageObject)")
            self.size = size:clone()
        else
            self.size = Geometry.Vector2:new(400, 200)
        end

end

function StageObject:setRotation(rotation)

        if rotation then
            assert(type(rotation) == "table", "Rotation is not an object (StageObject)")
            self.rotation = rotation:clone()
        else
            self.rotation = Geometry.Rotation2:new(0)
        end

end


function StageObject:setOffset(offset)

        if offset then
            assert(type(offset) == "table", "Offset is not an object (StageObject)")
            self.offset = offset:clone()
            local x = Math.clip(self.offset.x, 0, 1)
            local y = Math.clip(self.offset.y, 0, 1)
            self.offset:set(x, y)
        else
            self.offset = Geometry.Vector2:new(0.5, 0.5)
        end

end

function StageObject:setColor(color)

    if color then
        assert(type(color) == "table", "Color is not an object (StageObject)")
        self.color = color:clone()
    else
        self.color = Color:new(255, 255, 255, 255)
    end

end

function StageObject:updateHitbox()

    self.hitbox.position = self.position
    self.hitbox.size = self.size

end

function StageObject:isHitting(otherObject)

    return self.hitbox:isHitting(otherObject.hitbox)

end

return StageObject
