local class = require "lib.lua-oop"
local Stage = require "amour.stage"

local initial_stage = class("Stage-Initial", Stage)

function initial_stage:constructor(stageManager)

    Stage.constructor(self, stageManager) -- Don't forget to always call superclass constructor

end

-- We can say in this case that this is the general game init since
-- this stage is the first one in the game, so you can do initialization
-- stuff here such as setting the initial window title, size, etc.
function initial_stage:init()

    setBackgroundColor(0, 0, 0, 255)

    love.window.setTitle("Amour (Base)")

    -- Add an object to the stage, FpsObj is a basic object included
    -- with the engine, it simply shows the fps in the top left corner
    self:addObject(Basic.FpsObj:new())

    self.rect = Basic.RectangleObj:new(Geometry.Vector2:new(200, 200), Geometry.Rotation2.fromDegrees(20), Geometry.Vector2:new(200, 100), Color:new(255, 255, 255, 255))
    self:addObject(self.rect)

end

function initial_stage:update(dt)

    -- update code here

    self.rect.position:set(love.mouse.getX(), love.mouse.getY())

    if love.keyboard.isDown("right") then
        self.rect.rotation:rotate(math.rad(5))
    elseif love.keyboard.isDown("left") then
        self.rect.rotation:rotate(math.rad(-5))
    end

end

function initial_stage:draw()

    -- draw code here

end

function initial_stage:beforeChange()

    -- Code to be executed before changing to another stage
    -- This method is called by the StageManager
    -- Can be useful to destroy or stop the execution of something

end

return initial_stage -- Don't forget to always return the stage class
