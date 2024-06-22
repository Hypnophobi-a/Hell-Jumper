love.load = function()
    love.graphics.setDefaultFilter("nearest", "nearest")

    configuration = require("utilities/config")
    config = configuration.load()

    worldLoad = require("utilities/colliders")
    world = worldLoad.load()

    playerLoad = require("utilities/player")
    player = playerLoad.load(world)

    items = require("utilities/items")
    items.load()

    camera = require("libraries/camera")
    cam = camera()
    cam.scale = cam.scale * config.scale

    sti = require("libraries/sti")
    gameMap = sti("maps/world.lua")

    mapLoader = require("utilities/world")
    walls, chests = mapLoader.load()
end

love.update = function(dt)
    worldLoad.update(dt)
    playerLoad.update(dt)

    cam:lookAt(player.collider:getX(), player.collider:getY())
end

love.draw = function()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
        gameMap:drawLayer(gameMap.layers["Tile Layer 2"])
        player.anim:draw(player.spriteSheet, player.collider:getX(), player.collider:getY(), nil, nil, nil, 32, 32)

        --items.spawnItem(100, 100, "gold")

        if config.wireframe == true then
            world:draw()
        end
    cam:detach()

    love.graphics.print("Health: "..player.health, 8, 8)
    love.graphics.print("Score: "..player.score, 8, 24)
end