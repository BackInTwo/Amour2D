local class = require "lib.lua-oop"

require "engine.util.timer"

TimerManager = class "TimerManager"

function TimerManager:constructor()

    self.timers = {}
    self.counter = 0

end

function TimerManager:setTimeout(func, timeSecs)

    if not timeSecs or not (type(timeSecs) == "number") then
        timeSecs = 5
    end

    assert(type(func) == "function", "Parameter is not a function (TimeManager)")

    local newTimer = Timer:new(timeSecs, false, true)

    newTimer:onTimeout(func)

    newTimer:onTimeout(function(timer)
        timer:destroy()
        newTimer = nil
    end)

    self.timers[self.counter] = newTimer

    self.counter = self.counter + 1

end

function TimerManager:setInterval(func, timeSecs)

    if not timeSecs or not (type(timeSecs) == "number") then
        timeSecs = 0
    end

    assert(type(func) == "function", "Parameter is not a function (TimeManager)")

    local newTimer = Timer:new(timeSecs, false, true)

    newTimer:onTimeout(func)

    newTimer:onTimeout(function(timer)
        timer:requestReset()
    end)

    self.timers[self.counter] = newTimer

    self.counter = self.counter + 1

end

function TimerManager:update()

    for k,timer in pairs(self.timers) do

        if type(timer) == "table" then
            if timer.destroyed then
                self.timers[k] = nil
            else
                timer:update()
            end
        end

    end

end

function TimerManager:destroy(timerId)

    assert(type(timerId) == "number", "Parameter is not a number")

    local timer = self.timers[timerId]

    if type(timer) == "table" then
        timer:destroy()
    end

    self.timers[timerId] = nil

end