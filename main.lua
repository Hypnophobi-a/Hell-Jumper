love.load = function()
    love.graphics.setDefaultFilter("nearest", "nearest")

    configuration = require("utilities/config")
    config = configuration.load()

    worldLoad = require("utilities/colliders")
    world = worldLoad.load()

    playerLoad = require("utilities/player")
    player = playerLoad.load(world)

    camera = require("libraries/camera")
    cam = camera()
    cam.scale = cam.scale * config.scale

    mapLoader = require("utilities/world")
    walls = mapLoader.load()
end

love.update = function(dt)
    worldLoad.update(dt)
    playerLoad.update(dt)

    cam:lookAt(player.collider:getX(), player.collider:getY())
end

love.draw = function()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
        player.anim:draw(player.spriteSheet, player.collider:getX(), player.collider:getY(), nil, nil, nil, 32, 32)

        if config.wireframe == true then
            world:draw()
        end
    cam:detach()

    love.graphics.print("Health: "..player.health, 8, 8)
    love.graphics.print("Score: "..player.score, 8, 24)
end