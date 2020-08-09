local class = require "lib.lua-oop"
local Stage = require "engine.stage"

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

    self:addObject(FpsObj:new()) -- Add object, FpsObj is a basic object included with the engine

    self:setStaticInterval(function()
        print "Interval timeout! (2 seconds)"
    end, 2)

end

function initial_stage:update(dt)

    -- update code here

    if love.keyboard.isDown("return") then
        self.stageManager:changeStage("game.stages.template_stage")
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
