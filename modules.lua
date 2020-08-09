modules = {

    Core = require "engine.core",
    Basic        = require "engine.objects.basic",

    Stage        = require "engine.stage",
    StageManager = require "engine.stage.manager",
    StageObject  = require "engine.stage.object",
    Hitbox       = require "engine.stage.hitbox",

    Timer        = require "engine.util.timer",
    TimerManager = require "engine.util.timer.manager",

    Color        = require "engine.util.color",
    Math         = require "engine.util.math",
    Vector       = require "engine.util.math.vector",

    class        = require "lib.lua-oop",

    declare = function()

        class = modules.class

        Core = modules.Core
        Basic = modules.Basic

        Stage = modules.Stage
        StageObject = modules.StageObject
        StageManager = modules.StageManager
        Hitbox = modules.Hitbox

        Color = modules.Color
        Math = modules.Math
        Vector = modules.Vector
        Vector2 = modules.Vector.Vector2

        Timer = modules.Timer
        TimerManager = modules.TimerManager

    end

}

return modules
