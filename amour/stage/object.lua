local class = require "lib.lua-oop"

StageObject = class "StageObject"

function StageObject:constructor(position, rotation, size, color)

    self.isFirstUpdate = true
    self.enabled = true
    self.visible = true

    self.initialized = false

    self.tPos = position
    self.tRot = rotation
    self.tSize = size
    self.tCol = color

    self:setOffset("corner")

end

function StageObject:init() end

function StageObject:_init()

    if self.initialized then
        return
    end

    self.initialized = true

    self.parentStage.modules.declare()

    self.rotation = 0

    self:setPosition(self.tPos)
    self:setRotation(self.tRot)
    self:setOffset("corner")
    self:setSize(self.tSize)
    self:setColor(self.tCol)

    self.hitbox = Hitbox:new({position=self.position, size=self.size, poly=self.poly})

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

        self.isFirstUpdate = false

    end

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

        if not offset then
            self.offset = "center"
            return
        end

        if string.lower(offset) == "center" or "corner" then
            self.offset = offset
        else
            assert(false, "Offset should be either \"center\" or \"corner\"")
        end

end

function StageObject:getOffset()

    if not self.offset or string.lower(self.offset) == "center" then
        return 0.5
    elseif string.lower(self.offset) == "corner" then
        return 0
    else
        assert(false, "Offset should be either \"center\" or \"corner\"")
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

    self.hitbox.params.position = self.position
    self.hitbox.params.size = self.size
    self.hitbox.params.poly = self.poly

end

function StageObject:isHitting(otherObject)

    return self.hitbox:isHitting(otherObject.hitbox)

end

return StageObject
