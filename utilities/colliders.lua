local configuration = require("utilities/config")
local config = configuration.load()

local load = function()
    wf = require("libraries/windfield")
    world = wf.newWorld(0, 0)

    world:addCollisionClass("Chest")
    world:addCollisionClass("Player")

    if config.wireframe == true then
        world:setQueryDebugDrawing(true)
    end

    return world
end

local update = function(dt)
    world:update(dt)
end

return { 
    load = load,
    update = update
}