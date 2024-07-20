anim8 = require("libraries/anim8")
mapLoader = require("utilities/world")

local player = {
    health = 20,
    staminaMax = 10,
    score = 0,
    dir = "down",
    speed = 99,
    walkSpeed = 99,
    runSpeed = 198,
    walkingAnimSpeed = 0.2,
    runningAnimSpeed = 0.1,
    spriteSheet = love.graphics.newImage("sprites/player.png")
}

player.stamina = player.staminaMax

player.grid = anim8.newGrid(64, 64, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

player.animations = {
    down = anim8.newAnimation(player.grid("1-9", 11), player.walkingAnimSpeed),
    up = anim8.newAnimation(player.grid("1-9", 9), player.walkingAnimSpeed),
    left = anim8.newAnimation(player.grid("1-9", 10), player.walkingAnimSpeed),
    right = anim8.newAnimation(player.grid("1-9", 12), player.walkingAnimSpeed),
    runDown = anim8.newAnimation(player.grid("1-8", 37), player.walkingAnimSpeed),
    runUp = anim8.newAnimation(player.grid("1-8", 35), player.walkingAnimSpeed),
    runLeft = anim8.newAnimation(player.grid("1-8", 36), player.walkingAnimSpeed),
    runRight = anim8.newAnimation(player.grid("1-8", 38), player.walkingAnimSpeed)
}

player.anim = player.animations.down

local load = function(world)
    player.collider = world:newBSGRectangleCollider(512, 512, 32, 48, 9)
    player.collider:setFixedRotation(true)
    player.collider:setCollisionClass("Player")
    
    return player
end

local update = function(dt)
    local isMoving = false
    local isSprinting = false
    local vx, vy = 0, 0

    if love.keyboard.isDown("lshift") and player.stamina > 0 then
        isSprinting = true
        player.speed = player.runSpeed
        player.stamina = player.stamina - 0.05
    else
        player.speed = player.walkSpeed
    end

    if love.keyboard.isDown("d") then
        if isSprinting == true then
            player.anim = player.animations.runRight
        else
            player.anim = player.animations.right
        end

        isMoving = true
        vx = player.speed
        player.dir = "right"
    elseif love.keyboard.isDown("a") then
        if isSprinting == true then
            player.anim = player.animations.runLeft
        else
            player.anim = player.animations.left
        end

        isMoving = true
        vx = -player.speed
        player.dir = "left"
    end

    if love.keyboard.isDown("s") then
        if isSprinting == true then
            player.anim = player.animations.runDown
        else
            player.anim = player.animations.down
        end

        isMoving = true
        vy = player.speed
        player.dir = "down"
    elseif love.keyboard.isDown("w") then
        if isSprinting == true then
            player.anim = player.animations.runUp
        else
            player.anim = player.animations.up
        end
        
        isMoving = true
        vy = -player.speed
        player.dir = "up"
    end

    if vx ~= 0 and vy ~= 0 then
        local diagonalFactor = 1 / math.sqrt(2)
        vx = vx * diagonalFactor
        vy = vy * diagonalFactor
    end

    player.collider:setLinearVelocity(vx, vy)

    if not isMoving then
        player.anim:gotoFrame(1)
    end

    if player.stamina < player.staminaMax then
        player.stamina = player.stamina + 0.01
    end

    player.anim:update(dt)

    --[[
        if player.collider:enter("Chest") then
            print("touched chest")
        end
    ]]--
end

function love.keypressed(key, scancode, isrepeat)
    if scancode == "e" then
        local px, py = player.collider:getPosition()

        if player.dir == "right" then
            px = px + 16
        elseif player.dir == "left" then
            px = px - 16
        elseif player.dir == "up" then
            py = py - 16
        elseif player.dir == "down" then
            py = py + 16
        end

        local colliders = world:queryCircleArea(px, py, 16, {"Chest"})

        if #colliders > 0 then      
            if colliders[1].state == 0 then
                colliders[1].state = 1 -- Set the chest state as opened
                mapLoader.openChest(colliders[1].name)
            end
        end
    end
 end

return { 
    load = load,
    update = update
}