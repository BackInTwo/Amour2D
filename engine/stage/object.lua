local class = require "lib.lua-oop"

StageObject = class "StageObject"

function StageObject:constructor(position, size, color)

    self.isFirstUpdate = true
    self.enabled = true
    self.visible = true

end

function StageObject:init() end

function StageObject:_init()

    self:declareModules()

    self.rotation = 0
    self.hitbox = Hitbox:new(position, size)

    self:setColor(color)
    self:setPosition(position)
    self:setSize(size)

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
            self.position = Vector2:new(0, 0)
        end

end

function StageObject:setSize(size)

        if size then
            assert(type(size) == "table", "Size is not an object (StageObject)")
            self.size = size:clone()
        else
            self.size = Vector2:new(400, 200)
        end

end

function StageObject:setColor(color)

    if color then
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

-- declare global varibles for modules
function StageObject:declareModules()

    self.modules = self.parentStage.modules

    modules = self.modules
    class = self.modules.class

    Core = self.modules.Core
    Basic = self.modules.Basic
    Color = self.modules.Color
    Vector2 = self.modules.Vector.Vector2

    Stage = self.modules.Stage
    StageObject = self.modules.StageObject
    Hitbox = self.modules.Hitbox

    Timer = self.modules.Timer
    TimerManager = self.modules.TimerManager

end

return StageObject
