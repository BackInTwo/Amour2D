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

    Core.setBackgroundColor(0, 0, 0, 255)

    love.window.setTitle("Amour (Base)")

    -- Add an object to the stage, FpsObj is a basic object included
    -- with the engine, it simply shows the fps in the top left corner
    self:addObject(Basic.FpsObj:new())

end

function initial_stage:update(dt)

    -- update code here

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
